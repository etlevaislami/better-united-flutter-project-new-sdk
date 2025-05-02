import 'package:json_annotation/json_annotation.dart';

import '../../../util/date_util.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return yearMonthDayFormatter.parse(json, true);
  }

  @override
  String toJson(DateTime json) => yearMonthDayFormatter.format(json);
}
