import 'package:json_annotation/json_annotation.dart';

part 'language_request.g.dart';

@JsonSerializable()
class LanguageRequest {
  final int languageId;

  LanguageRequest(this.languageId);

  factory LanguageRequest.fromJson(Map<String, dynamic> json) =>
      _$LanguageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LanguageRequestToJson(this);
}
