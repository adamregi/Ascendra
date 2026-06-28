import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/executive_overview_model.dart';
import '../models/leadership_pipeline_model.dart';
import '../models/alert_preview_model.dart';
import '../models/recommendation_preview_model.dart';
import '../../../../core/services/logger_service.dart';

part 'dashboard_repository_impl.g.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final SupabaseClient _supabase;

  DashboardRepositoryImpl(this._supabase);

  Future<T> _executeRpc<T>({
    required String rpcName,
    Map<String, dynamic>? params,
    required T Function(dynamic) onSuccess,
  }) async {
    final startTime = DateTime.now();
    try {
      final response = await _supabase.rpc(rpcName, params: params);

      LoggerService.logRpc(
        rpcName: rpcName,
        duration: DateTime.now().difference(startTime),
        isSuccess: true,
        userId: _supabase.auth.currentUser?.id,
      );

      return onSuccess(response);
    } catch (e) {
      String? exceptionType = e.runtimeType.toString();
      String? statusCode;

      if (e is PostgrestException) {
        statusCode = e.code;
      }

      LoggerService.logRpc(
        rpcName: rpcName,
        duration: DateTime.now().difference(startTime),
        isSuccess: false,
        error: e,
        userId: _supabase.auth.currentUser?.id,
        exceptionType: exceptionType,
        statusCode: statusCode,
      );

      rethrow;
    }
  }

  @override
  Future<ExecutiveOverviewModel> getExecutiveOverview() {
    return _executeRpc(
      rpcName: 'get_executive_overview',
      onSuccess:
          (data) =>
              ExecutiveOverviewModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<LeadershipPipelineModel> getLeadershipPipeline() {
    return _executeRpc(
      rpcName: 'get_leadership_pipeline',
      onSuccess:
          (data) =>
              LeadershipPipelineModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<AlertPreviewModel> getAlerts() async {
    final companyId = await _supabase.rpc('get_user_company_id');
    if (companyId == null) {
      return const AlertPreviewModel();
    }

    return _executeRpc(
      rpcName: 'get_executive_brief_data',
      params: {'p_company_id': companyId},
      onSuccess:
          (data) => AlertPreviewModel.fromJson(data as Map<String, dynamic>),
    );
  }

  @override
  Future<RecommendationPreviewModel> getRecommendations() async {
    final leaderId = _supabase.auth.currentUser?.id;
    final companyId = await _supabase.rpc('get_user_company_id');

    if (leaderId == null || companyId == null) {
      return const RecommendationPreviewModel();
    }

    return _executeRpc(
      rpcName: 'get_recommendation_center',
      params: {'p_company_id': companyId, 'p_leader_id': leaderId},
      onSuccess:
          (data) =>
              RecommendationPreviewModel.fromJson(data as Map<String, dynamic>),
    );
  }
}

@riverpod
DashboardRepository dashboardRepository(Ref ref) {
  return DashboardRepositoryImpl(Supabase.instance.client);
}
