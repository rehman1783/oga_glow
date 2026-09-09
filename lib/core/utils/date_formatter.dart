class DateFormatter {
  DateFormatter._();

  static String formatPakistanDateTime(DateTime date) {
    final pakistanTime = date.toUtc().add(const Duration(hours: 5));
    final day = pakistanTime.day;
    final month = _monthName(pakistanTime.month);
    final year = pakistanTime.year;
    final hour = pakistanTime.hour;
    final minute = pakistanTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;

    return '$day $month $year • $hour12:$minute $period';
  }

  static String formatJoinedDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return '';
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    final month = _monthName(parsed.month);
    return '$month ${parsed.year}';
  }

  static String formatFullDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return '';
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) return rawDate;
    final day = parsed.day.toString().padLeft(2, '0');
    final month = _monthName(parsed.month);
    return '$day $month ${parsed.year}';
  }

  static String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    if (month < 1 || month > 12) return '';
    return months[month - 1];
  }
}
