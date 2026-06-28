import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_controller.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/app_button.dart';

enum LoginMode { password, otp }

enum OtpStep { send, verify }

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _distributorIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();

  LoginMode _mode = LoginMode.password;
  OtpStep _otpStep = OtpStep.send;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      _distributorIdController.text = 'DIST_ALICE';
      _passwordController.text = 'password123';
    }
  }

  String _mapAuthError(dynamic error) {
    if (error == null) return 'Something went wrong. Please try again later.';
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('invalid login credentials') ||
        errorStr.contains('invalid credentials')) {
      return 'Incorrect Distributor ID or password.';
    }
    if (errorStr.contains('not_found') || errorStr.contains('not found')) {
      return 'Distributor ID not found.';
    }
    if (errorStr.contains('timeout') ||
        errorStr.contains('socket') ||
        errorStr.contains('network')) {
      return 'Check your internet connection and try again.';
    }
    return 'Something went wrong. Please try again later.';
  }

  void _onAuthenticate() {
    final distributorId = _distributorIdController.text.trim();
    if (distributorId.isEmpty) return;

    if (_mode == LoginMode.password) {
      final password = _passwordController.text;
      if (password.isEmpty) return;
      ref
          .read(authControllerProvider.notifier)
          .signInWithPassword(distributorId, password);
    } else {
      if (_otpStep == OtpStep.send) {
        ref.read(authControllerProvider.notifier).sendOtp(distributorId).then((
          _,
        ) {
          final authState = ref.read(authControllerProvider);
          if (!authState.hasError) {
            setState(() {
              _otpStep = OtpStep.verify;
            });
          }
        });
      } else {
        final otp = _otpController.text.trim();
        if (otp.isEmpty) return;
        ref.read(authControllerProvider.notifier).verifyOtp(distributorId, otp);
      }
    }
  }

  @override
  void dispose() {
    _distributorIdController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    _passwordFocusNode.dispose();
    _otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  Center(
                    child: Image.asset(
                      'assets/branding/ascendra_logo.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Ascendra',
                    style: AppTypography.displayLgMobile.copyWith(
                      color: AppColors.onBackground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 280),
                      child: Text(
                        'Lead. Inspire. Ascend.',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome back',
                    style: AppTypography.bodyLg.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Form Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                      border: Border.all(color: AppColors.borderSubtle),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          label: 'Distributor ID',
                          controller: _distributorIdController,
                          hint: 'Enter your Distributor ID',
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          enableSuggestions: false,
                          autofillHints: const [AutofillHints.username],
                          onSubmitted: (_) {
                            if (_mode == LoginMode.password) {
                              _passwordFocusNode.requestFocus();
                            }
                          },
                        ),
                        const SizedBox(height: 16),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child:
                              _mode == LoginMode.password
                                  ? Column(
                                    key: const ValueKey('password_flow'),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AppPasswordField(
                                        label: 'Password',
                                        controller: _passwordController,
                                        focusNode: _passwordFocusNode,
                                        textInputAction: TextInputAction.done,
                                        autofillHints: const [
                                          AutofillHints.password,
                                        ],
                                        labelAction: TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            tapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            foregroundColor:
                                                AppColors.secondary,
                                          ),
                                          child: Text(
                                            'Forgot password?',
                                            style: AppTypography.labelMd
                                                .copyWith(
                                                  color: AppColors.secondary,
                                                ),
                                          ),
                                        ),
                                        onSubmitted: (_) {
                                          if (!isLoading) _onAuthenticate();
                                        },
                                      ),
                                    ],
                                  )
                                  : Column(
                                    key: const ValueKey('otp_flow'),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (_otpStep == OtpStep.verify)
                                        AppTextField(
                                          label: 'One-Time Password (OTP)',
                                          controller: _otpController,
                                          hint:
                                              'Enter the OTP sent to your phone',
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          focusNode: _otpFocusNode,
                                          onSubmitted: (_) {
                                            if (!isLoading) _onAuthenticate();
                                          },
                                        ),
                                    ],
                                  ),
                        ),

                        const SizedBox(height: 32),
                        AppButton(
                          onPressed: isLoading ? null : _onAuthenticate,
                          isLoading: isLoading,
                          label:
                              _mode == LoginMode.password
                                  ? 'Log In'
                                  : (_otpStep == OtpStep.send
                                      ? 'Send OTP'
                                      : 'Verify OTP'),
                        ),

                        if (authState.hasError) ...[
                          const SizedBox(height: 16),
                          Text(
                            _mapAuthError(authState.error),
                            style: AppTypography.bodyMd.copyWith(
                              color: AppColors.error,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],

                        const SizedBox(height: 32),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.surfaceVariant),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                'OR',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.surfaceVariant),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        TextButton(
                          onPressed:
                              isLoading
                                  ? null
                                  : () {
                                    setState(() {
                                      if (_mode == LoginMode.password) {
                                        _mode = LoginMode.otp;
                                        _otpStep = OtpStep.send;
                                      } else {
                                        _mode = LoginMode.password;
                                      }
                                      ref.invalidate(authControllerProvider);
                                    });
                                  },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.onSurface,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            _mode == LoginMode.password
                                ? 'Use One-Time Password (OTP)'
                                : 'Login with Password',
                            style: AppTypography.labelMd,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Footer
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New here? ',
                        style: AppTypography.labelMd.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Create your account',
                          style: AppTypography.labelMd.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
