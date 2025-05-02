import 'package:json_annotation/json_annotation.dart';

part 'invite_self_response.g.dart';

@JsonSerializable()
class InviteSelfResponse {
  final int id;

  InviteSelfResponse(
    this.id,
  );

  factory InviteSelfResponse.fromJson(Map<String, dynamic> json) =>
      _$InviteSelfResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InviteSelfResponseToJson(this);
}
