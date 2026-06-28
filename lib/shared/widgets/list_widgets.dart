import 'package:flutter/material.dart';
import '../../core/constants/app_spacing.dart';

class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}

class InfiniteListFooter extends StatelessWidget {
  final bool hasMore;
  final bool isLoadingMore;
  final String noMoreText;

  const InfiniteListFooter({
    super.key,
    required this.hasMore,
    required this.isLoadingMore,
    this.noMoreText = 'No more items',
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return const LoadMoreIndicator();
    }

    if (!hasMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Center(
          child: Text(
            noMoreText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
