import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_recognition_model.freezed.dart';
part 'member_recognition_model.g.dart';

@freezed
abstract class MemberRecognitionModel with _$MemberRecognitionModel {
  const factory MemberRecognitionModel({
    required String name,
    required String description,
    @JsonKey(name: 'earned_date') required DateTime earnedDate,
    required String category,
    required String icon,
    required int level,
    required int points,
  }) = _MemberRecognitionModel;

  factory MemberRecognitionModel.fromJson(Map<String, dynamic> json) =>
      _$MemberRecognitionModelFromJson(json);
}
