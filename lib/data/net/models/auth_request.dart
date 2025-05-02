import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import '../../enum/grant_type.dart';

part 'auth_request.g.dart';

String getPlatform() {
  if (Platform.isAndroid) {
    return "android";
  } else if (Platform.isIOS) {
    return "ios";
  }
  return "";
}

@JsonSerializable()
class AuthRequest {
  @JsonKey(name: "grant_type")
  GrantType grantType;
  @JsonKey(name: "client_id")
  String clientId = "bu_api";
  @JsonKey(name: "username")
  String? email;
  String? password;
  @JsonKey(name: "google_id_token")
  String? googleIdToken;
  @JsonKey(name: "apple_id_token")
  String? appleIdToken;
  @JsonKey(name: "facebook_token")
  String? facebookToken;
  String client = getPlatform();

  @JsonKey(name: "client_secret", defaultValue: "")
  String clientSecret = "";
  int persistent;

  AuthRequest(this.grantType,
      {this.persistent = 1,
      this.email,
      this.password,
      this.googleIdToken,
      this.appleIdToken,
      this.facebookToken});

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
