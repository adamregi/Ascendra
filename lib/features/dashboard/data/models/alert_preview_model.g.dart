// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AlertPreviewModel _$AlertPreviewModelFromJson(Map<String, dynamic> json) =>
    _AlertPreviewModel(
      topAlerts:
          (json['top_alerts'] as List<dynamic>?)
              ?.map((e) => AlertItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      stats:
          json['stats'] == null
              ? null
              : AlertStats.fromJson(json['stats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlertPreviewModelToJson(_AlertPreviewModel instance) =>
    <String, dynamic>{
      'top_alerts': instance.topAlerts,
      'stats': instance.stats,
    };

_AlertItem _$AlertItemFromJson(Map<String, dynamic> json) => _AlertItem(
  id: json['id'] as String,
  type: json['type'] as String,
  severity: json['severity'] as String,
  title: json['title'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AlertItemToJson(_AlertItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'severity': instance.severity,
      'title': instance.title,
      'created_at': instance.createdAt.toIso8601String(),
    };

_AlertStats _$AlertStatsFromJson(Map<String, dynamic> json) => _AlertStats(
  highRiskCount: (json['high_risk_count'] as num).toInt(),
  promotionCount: (json['promotion_count'] as num).toInt(),
  recognitionCount: (json['recognition_count'] as num).toInt(),
);

Map<String, dynamic> _$AlertStatsToJson(_AlertStats instance) =>
    <String, dynamic>{
      'high_risk_count': instance.highRiskCount,
      'promotion_count': instance.promotionCount,
      'recognition_count': instance.recognitionCount,
    };
