import 'package:json_annotation/json_annotation.dart';

part 'push_request.g.dart';

@JsonSerializable()
class PushRequest {
  final String pushToken;
  final String deviceId;

  factory PushRequest.fromJson(Map<String, dynamic> json) =>
      _$PushRequestFromJson(json);

  PushRequest(this.pushToken, this.deviceId);

  Map<String, dynamic> toJson() => _$PushRequestToJson(this);
}
