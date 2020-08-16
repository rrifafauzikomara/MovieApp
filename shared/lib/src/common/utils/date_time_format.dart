class DateTimeFormat {
  static String day(int dayWeek) {
    switch (dayWeek) {
      case 1:
        return "MO";
        break;
      case 2:
        return "TU";
        break;
      case 3:
        return "WE";
        break;
      case 4:
        return "TH";
        break;
      case 5:
        return "FR";
        break;
      case 6:
        return "SA";
        break;
      case 7:
        return "SU";

        break;
      default:
        return "MO";
    }
  }
}
