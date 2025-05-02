import 'package:json_annotation/json_annotation.dart';

enum GrantType {
  @JsonValue("password")
  password,
  @JsonValue("google_token")
  googleToken,
  @JsonValue("apple_token")
  appleToken,
  @JsonValue("facebook_token")
  facebookToken,
}
