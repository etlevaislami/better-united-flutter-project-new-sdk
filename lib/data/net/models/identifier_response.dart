import 'package:json_annotation/json_annotation.dart';

part 'identifier_response.g.dart';

@JsonSerializable()
class IdentifierResponse {
  final int id;

  IdentifierResponse(this.id);

  factory IdentifierResponse.fromJson(Map<String, dynamic> json) =>
      _$IdentifierResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IdentifierResponseToJson(this);
}
