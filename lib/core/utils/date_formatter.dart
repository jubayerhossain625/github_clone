import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatDate(DateTime date) {
  return DateFormat('MM-dd-yyyy HH:mm').format(date);
}


String formatDateAge(DateTime date) {
  return timeago.format(date);
}