import 'package:json_annotation/json_annotation.dart';

part 'nickname_request.g.dart';

@JsonSerializable()
class NicknameRequest {
  final String nickname;

  factory NicknameRequest.fromJson(Map<String, dynamic> json) =>
      _$NicknameRequestFromJson(json);

  NicknameRequest(this.nickname);

  Map<String, dynamic> toJson() => _$NicknameRequestToJson(this);
}
