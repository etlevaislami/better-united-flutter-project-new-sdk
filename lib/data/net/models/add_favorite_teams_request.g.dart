// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_favorite_teams_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFavoriteTeamsRequest _$AddFavoriteTeamsRequestFromJson(
        Map<String, dynamic> json) =>
    AddFavoriteTeamsRequest(
      (json['teams'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
    );

Map<String, dynamic> _$AddFavoriteTeamsRequestToJson(
        AddFavoriteTeamsRequest instance) =>
    <String, dynamic>{
      'teams': instance.teams,
    };
