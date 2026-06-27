import '../../data/models/executive_overview_model.dart';
import '../../data/models/leadership_pipeline_model.dart';
import '../../data/models/alert_preview_model.dart';
import '../../data/models/recommendation_preview_model.dart';

abstract class DashboardRepository {
  Future<ExecutiveOverviewModel> getExecutiveOverview();
  Future<LeadershipPipelineModel> getLeadershipPipeline();
  Future<AlertPreviewModel> getAlerts();
  Future<RecommendationPreviewModel> getRecommendations();
}
