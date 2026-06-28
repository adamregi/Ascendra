import 'package:flutter/material.dart';

import 'list_widgets.dart';
import 'pull_to_refresh_indicator.dart';

class PagedListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;
  final Widget emptyState;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;

  const PagedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onRefresh,
    required this.onLoadMore,
    required this.hasMore,
    required this.isLoadingMore,
    required this.emptyState,
    this.padding,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return PullToRefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: emptyState,
          ),
        ),
      );
    }

    return PullToRefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoadingMore &&
              hasMore &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 200) {
            onLoadMore();
          }
          return false;
        },
        child: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: padding,
          itemCount: items.length + 1,
          itemBuilder: (context, index) {
            if (index == items.length) {
              return InfiniteListFooter(
                hasMore: hasMore,
                isLoadingMore: isLoadingMore,
              );
            }
            return itemBuilder(context, items[index], index);
          },
        ),
      ),
    );
  }
}
