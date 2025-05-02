import 'package:json_annotation/json_annotation.dart';

import '../../../util/date_util.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return apiDateFormatter.parse(json, true).toLocal();
  }

  @override
  String toJson(DateTime date) => apiDateFormatter.format(date.toUtc());
}
