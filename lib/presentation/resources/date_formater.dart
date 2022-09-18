import 'package:easy_localization/easy_localization.dart';

class DateFormatter {

  static const String dateFormat = ' MM/dd/yyyy  HH:MM';

  static getFormattedDate(DateTime date){
    return DateFormat(dateFormat).format(date);

  }
}