import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "access_token")
  String accessToken;
  @JsonKey(name: "expires_in")
  int expiresIn;
  @JsonKey(name: "token_type")
  String tokenType;
  String scope;
  @JsonKey(name: "refresh_token")
  String refreshToken;

  AuthResponse(this.accessToken, this.expiresIn, this.tokenType, this.scope,
      this.refreshToken);

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
  static const fromJsonFactory = _$AuthResponseFromJson;
}
