import 'package:freezed_annotation/freezed_annotation.dart';

part 'alert_preview_model.freezed.dart';
part 'alert_preview_model.g.dart';

@freezed
abstract class AlertPreviewModel with _$AlertPreviewModel {
  const factory AlertPreviewModel({
    @JsonKey(name: 'top_alerts') @Default([]) List<AlertItem> topAlerts,
    @JsonKey(name: 'stats') AlertStats? stats,
  }) = _AlertPreviewModel;

  factory AlertPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$AlertPreviewModelFromJson(json);
}

@freezed
abstract class AlertItem with _$AlertItem {
  const factory AlertItem({
    required String id,
    required String type,
    required String severity,
    required String title,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _AlertItem;

  factory AlertItem.fromJson(Map<String, dynamic> json) =>
      _$AlertItemFromJson(json);
}

@freezed
abstract class AlertStats with _$AlertStats {
  const factory AlertStats({
    @JsonKey(name: 'high_risk_count') required int highRiskCount,
    @JsonKey(name: 'promotion_count') required int promotionCount,
    @JsonKey(name: 'recognition_count') required int recognitionCount,
  }) = _AlertStats;

  factory AlertStats.fromJson(Map<String, dynamic> json) =>
      _$AlertStatsFromJson(json);
}
