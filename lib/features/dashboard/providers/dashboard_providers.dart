import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/ref_extensions.dart';
import '../data/repositories/dashboard_repository_impl.dart';
import '../data/models/executive_overview_model.dart';
import '../data/models/leadership_pipeline_model.dart';
import '../data/models/alert_preview_model.dart';
import '../data/models/recommendation_preview_model.dart';

part 'dashboard_providers.g.dart';

@riverpod
Future<ExecutiveOverviewModel> executiveOverview(Ref ref) {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(dashboardRepositoryProvider).getExecutiveOverview();
}

@riverpod
Future<LeadershipPipelineModel> leadershipPipeline(Ref ref) {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(dashboardRepositoryProvider).getLeadershipPipeline();
}

@riverpod
Future<AlertPreviewModel> alertPreview(Ref ref) {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(dashboardRepositoryProvider).getAlerts();
}

@riverpod
Future<RecommendationPreviewModel> recommendationPreview(Ref ref) {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(dashboardRepositoryProvider).getRecommendations();
}
