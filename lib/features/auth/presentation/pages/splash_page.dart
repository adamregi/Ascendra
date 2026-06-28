import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../../app/bootstrap/bootstrap_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  bool _isVideoFinished = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache the logo to prevent any flicker if we need to show it
    precacheImage(
      const AssetImage('assets/branding/ascendra_logo.png'),
      context,
    );
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(
        'assets/branding/Splash_screen.mp4',
      );
      await _controller.initialize();

      if (!mounted) return;

      _controller.setVolume(0.0);
      _controller.setLooping(false);

      _controller.addListener(_videoListener);

      setState(() {
        _isVideoInitialized = true;
      });

      // Start playback immediately upon initialization
      _controller.play();
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isVideoFinished = true; // Force fallback progression
        });
        _checkAndNavigate(ref.read(bootstrapProvider));
      }
    }
  }

  void _videoListener() {
    if (!_controller.value.isPlaying &&
        _controller.value.position >= _controller.value.duration &&
        _controller.value.duration > Duration.zero &&
        !_isVideoFinished) {
      // Video has finished playing
      setState(() {
        _isVideoFinished = true;
      });
      _checkAndNavigate(ref.read(bootstrapProvider));
    }
  }

  void _checkAndNavigate(BootstrapState state) {
    // Only navigate if the video is completely finished (or errored)
    if (!_isVideoFinished) return;

    if (state == BootstrapState.ready) {
      context.go('/dashboard');
    } else if (state == BootstrapState.unauthenticated ||
        state == BootstrapState.unauthorizedRole) {
      context.go('/login');
    }
    // If still initializing, do nothing. The UI will show a loader.
    // We rely on the ref.listen below to catch when it finally finishes.
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to bootstrap changes. If bootstrap finishes AFTER the video, this will trigger navigation.
    ref.listen<BootstrapState>(bootstrapProvider, (previous, next) {
      _checkAndNavigate(next);
    });

    final bootstrapState = ref.watch(bootstrapProvider);

    return Scaffold(
      backgroundColor: Colors.black, // Matches native splash perfectly
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Fallback or Loading Logo (Shows before video initializes or on error)
          if (!_isVideoInitialized || _hasError)
            Center(
              child: Image.asset(
                'assets/branding/ascendra_logo.png',
                width: 150,
                height: 150,
              ),
            ),

          // 2. The Video Player
          if (_isVideoInitialized && !_hasError)
            AnimatedOpacity(
              opacity: _isVideoInitialized ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),

          // 3. Minimal loading spinner if video ends but bootstrap is still churning
          if (_isVideoFinished &&
              (bootstrapState == BootstrapState.initializing ||
                  bootstrapState == BootstrapState.fetchingProfile))
            const Positioned(
              bottom: 64,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white54,
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
