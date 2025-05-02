import 'package:easy_localization/easy_localization.dart';

final DateFormat fullNotationDateWithHours = DateFormat('dd MMM yyyy - HH:mm');
final DateFormat yearMonthDayFormatter = DateFormat('yyyy-MM-dd');
final DateFormat dayMonthYearFormatter = DateFormat('dd MMM yyyy');
final DateFormat dayMonthYearFormatterWithSeparator = DateFormat('dd-MM-yyyy');
final DateFormat hoursMinutesFormatter = DateFormat('HH:mm');
final DateFormat dayMonthYearHoursFormatter = DateFormat('dd MMM yyyy (HH:mm)');
final DateFormat apiDateFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");
final DateFormat fullDateFormatter = DateFormat('dd MMMM yyyy');
final DateFormat monthFormatter = DateFormat('MMMM yyyy');
final DateFormat dayMonthYearHoursWithDotsFormatter =
    DateFormat('dd.MM.yyyy - HH:mm');

extension DateExtension on DateTime {
  DateTime untilMidnight() {
    return DateTime(year, month, day);
  }
}

String formatDatePeriod(DateTime startDate, DateTime endDate) {
  if (startDate.year == endDate.year) {
    if (startDate.month == endDate.month) {
      if (startDate.day == endDate.day) {
        return DateFormat('MMM dd, yyyy').format(startDate);
      } else {
        return DateFormat('MMM d').format(startDate) +
            " - " +
            DateFormat('d, yyyy').format(endDate);
      }
    } else {
      return DateFormat('MMM d').format(startDate) +
          " - " +
          DateFormat('MMM d, yyyy').format(endDate);
    }
  } else {
    return DateFormat('MMM d, yyyy').format(startDate) +
        " - " +
        DateFormat('MMM d, yyyy').format(endDate);
  }
}

/// Returns formatted date for start of season - end of season.
String formatSeasonalPeriod(DateTime startDate, DateTime endDate) {
  // Format the months and year
  String startMonth = DateFormat('MMMM').format(startDate);
  String endMonth = DateFormat('MMMM').format(endDate);
  String yearStart = DateFormat('yyyy').format(startDate);
  String yearEnd = DateFormat('yyyy').format(endDate);

  // Construct the final formatted string
  if (yearStart == yearEnd) {
    return '$startMonth - $endMonth $yearStart';
  } else {
    // if the end date is in another year then also show the year of the start date.
    return '$startMonth $yearStart - $endMonth $yearEnd';
  }
}

String daysLeftFormatted(int daysLeft) {
  return daysLeft < 0
      ? "ended".tr()
      : daysLeft == 0
          ? "ends_today".tr()
          : "daysLeft".tr(args: [daysLeft.toString()]);
}
