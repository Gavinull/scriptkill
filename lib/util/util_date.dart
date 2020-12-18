class AppDate {
  static String full = "yyyy-MM-dd HH:mm:ss";

  static String formatDate(DateTime dateTime, {bool isUtc, String format}) {
    if (dateTime == null) return "";
    format = format ?? full;
    if (format.contains("yy")) {
      String year = dateTime.year.toString();
      if (format.contains("yyyy")) {
        format = format.replaceAll("yyyy", year);
      } else {
        format = format.replaceAll(
            "yy", year.substring(year.length - 2, year.length));
      }
    }

    format = _comFormat(dateTime.month, format, 'M', 'MM');
    format = _comFormat(dateTime.day, format, 'd', 'dd');
    format = _comFormat(dateTime.hour, format, 'H', 'HH');
    format = _comFormat(dateTime.minute, format, 'm', 'mm');
    format = _comFormat(dateTime.second, format, 's', 'ss');
    format = _comFormat(dateTime.millisecond, format, 'S', 'SSS');

    return format;
  }

  static String _comFormat(
      int value, String format, String single, String full) {
    if (format.contains(single)) {
      if (format.contains(full)) {
        format =
            format.replaceAll(full, value < 10 ? '0$value' : value.toString());
      } else {
        format = format.replaceAll(single, value.toString());
      }
    }
    return format;
  }

  static String getTimeDate(String comTime) {
    var compareTime = DateTime.parse(comTime);
    String weekDay = '';
    switch (compareTime.weekday) {
      case 2:
        weekDay = '周二';
        break;
      case 3:
        weekDay = '周三';
        break;
      case 4:
        weekDay = '周四';
        break;
      case 5:
        weekDay = '周五';
        break;
      case 6:
        weekDay = '周六';
        break;
      case 7:
        weekDay = '周日';
        break;
      default:
        weekDay = '周一';
    }
    return '${compareTime.month}-${compareTime.day}  $weekDay';
  }
}
