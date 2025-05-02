// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) => AuthRequest(
      $enumDecode(_$GrantTypeEnumMap, json['grant_type']),
      persistent: (json['persistent'] as num?)?.toInt() ?? 1,
      email: json['username'] as String?,
      password: json['password'] as String?,
      googleIdToken: json['google_id_token'] as String?,
      appleIdToken: json['apple_id_token'] as String?,
      facebookToken: json['facebook_token'] as String?,
    )
      ..clientId = json['client_id'] as String
      ..client = json['client'] as String
      ..clientSecret = json['client_secret'] as String? ?? '';

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'grant_type': _$GrantTypeEnumMap[instance.grantType]!,
      'client_id': instance.clientId,
      'username': instance.email,
      'password': instance.password,
      'google_id_token': instance.googleIdToken,
      'apple_id_token': instance.appleIdToken,
      'facebook_token': instance.facebookToken,
      'client': instance.client,
      'client_secret': instance.clientSecret,
      'persistent': instance.persistent,
    };

const _$GrantTypeEnumMap = {
  GrantType.password: 'password',
  GrantType.googleToken: 'google_token',
  GrantType.appleToken: 'apple_token',
  GrantType.facebookToken: 'facebook_token',
};
