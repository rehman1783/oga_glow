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
    return months[month - 1];
  }
}
