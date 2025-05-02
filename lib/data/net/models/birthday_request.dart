import 'package:json_annotation/json_annotation.dart';

import '../converters/local_date_converter.dart';

part 'birthday_request.g.dart';

@JsonSerializable()
class BirthdayRequest {
  @DateTimeConverter()
  final DateTime dateOfBirth;

  factory BirthdayRequest.fromJson(Map<String, dynamic> json) =>
      _$BirthdayRequestFromJson(json);

  BirthdayRequest(this.dateOfBirth);

  Map<String, dynamic> toJson() => _$BirthdayRequestToJson(this);
}
