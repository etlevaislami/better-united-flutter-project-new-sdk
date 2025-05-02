// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthday_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BirthdayRequest _$BirthdayRequestFromJson(Map<String, dynamic> json) =>
    BirthdayRequest(
      const DateTimeConverter().fromJson(json['dateOfBirth'] as String),
    );

Map<String, dynamic> _$BirthdayRequestToJson(BirthdayRequest instance) =>
    <String, dynamic>{
      'dateOfBirth': const DateTimeConverter().toJson(instance.dateOfBirth),
    };
