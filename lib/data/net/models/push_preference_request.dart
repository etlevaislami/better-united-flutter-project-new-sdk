import 'package:json_annotation/json_annotation.dart';

part 'push_preference_request.g.dart';

@JsonSerializable()
class PushPreferenceRequest {
  final bool notificationAppUpdatesEnabled;
  final bool notificationPoulesEnabled;
  final bool notificationAccountEnabled;
  final bool notificationTipEnabled;

  PushPreferenceRequest(
      this.notificationAppUpdatesEnabled,
      this.notificationPoulesEnabled,
      this.notificationAccountEnabled,
      this.notificationTipEnabled);

  factory PushPreferenceRequest.fromJson(Map<String, dynamic> json) =>
      _$PushPreferenceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PushPreferenceRequestToJson(this);
}
