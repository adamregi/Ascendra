import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final String? title;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;
  final Future<void> Function()? onRefresh;
  final Widget? floatingActionButton;

  const BasePage({
    super.key,
    required this.body,
    this.title,
    this.isLoading = false,
    this.error,
    this.onRetry,
    this.onRefresh,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: title != null ? AppBar(title: Text(title!)) : null,
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          child: Stack(
            children: [
              _buildBody(),
              if (error != null) _buildErrorBanner(),
              if (isLoading) _buildLoadingOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (onRefresh != null) {
      return RefreshIndicator(onRefresh: onRefresh!, child: body);
    }
    return body;
  }

  Widget _buildErrorBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        color: AppColors.error,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  error!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (onRetry != null)
                TextButton(
                  onPressed: onRetry,
                  child: const Text(
                    'RETRY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black26,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
