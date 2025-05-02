import 'package:json_annotation/json_annotation.dart';

part 'ApiError.g.dart';

@JsonSerializable()
class ApiError {
  String error;
  @JsonKey(name: "error_description")
  String? errorDescription;

  ApiError(this.error, this.errorDescription);

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
  static const fromJsonFactory = _$ApiErrorFromJson;
}