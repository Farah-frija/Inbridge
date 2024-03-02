import 'package:inbridge/test/Enums/NotificationMessage.dart';
import 'package:inbridge/test/Enums/time.dart';
import 'package:inbridge/test/Models/TimeNumber.dart';
import 'package:inbridge/test/Models/User.dart';
import 'package:inbridge/test/Widgets/Notifuser.dart';

class Notifications {
  Notifications(
      {required DateTime? date,
      required User? user,
      required NotificationMessage? message})
      : _date = date,
        _user = user,
        _message = message;
  DateTime? _date;
  User? _user;
  NotificationMessage? _message;
  String get text => _message == NotificationMessage.commentaire
      ? "Commented on your project"
      : "Rated your project";
  DateTime? get date => _date;
  User? get user => _user;
  NotificationMessage? get message => _message;

  String? calculateAndFormatTimeDifference() {
    if (_date != null) {
      DateTime now = DateTime.now();
      Duration difference = now.difference(_date!);

      if (difference.inSeconds < 60) {
        return (difference.inSeconds == 0)
            ? "Now"
            : "${difference.inSeconds}s ago";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ago";
      } else if (difference.inDays <= 7) {
        return "${difference.inDays}d ago"; // Display in days if less than or equal to 7 days
      } else if (difference.inDays <= 28) {
        int weeks = (difference.inDays / 7).floor();
        return "${weeks}w ago"; // Display in weeks if less than or equal to 4 weeks
      } else if (difference.inDays < 365) {
        int months = (difference.inDays / 30).floor();
        if (months == 12) return "1y ago";
        return "${months}mo ago"; // Display in months if less than or equal to 12 months
      } else {
        int years = (difference.inDays / 365).floor();
        return "${years}y ago"; // Display in years if more than 1 year
      }
    }
    return null;
  }
}

final List<Notifications> notifications = [
  Notifications(
    date: DateTime(2023, 12, 31, 18, 30, 45),
    message: NotificationMessage.rate,
    user: sam,
  ),
  Notifications(
    date: DateTime(2022, 12, 31, 18, 30, 45),
    message: NotificationMessage.commentaire,
    user: sophia,
  ),
  Notifications(
    date: DateTime(2021, 12, 30, 14, 45, 30),
    message: NotificationMessage.rate,
    user: greg,
  ),
  Notifications(
    date: DateTime(2024, 1, 26, 11, 0, 10),
    message: NotificationMessage.commentaire,
    user: john,
  ),
  Notifications(
    date: DateTime(2024, 01, 28, 12, 0, 0),
    message: NotificationMessage.rate,
    user: olivia,
  ),
  Notifications(
    date: DateTime(2023, 12, 27, 5, 30, 0),
    message: NotificationMessage.commentaire,
    user: james,
  ),
  Notifications(
    date: DateTime(2023, 12, 31, 18, 30, 45),
    message: NotificationMessage.rate,
    user: sam,
  ),
  Notifications(
    date: DateTime(2022, 12, 31, 18, 30, 45),
    message: NotificationMessage.commentaire,
    user: sophia,
  ),
  Notifications(
    date: DateTime(2021, 12, 30, 14, 45, 30),
    message: NotificationMessage.rate,
    user: greg,
  ),
  Notifications(
    date: DateTime(2024, 1, 26, 11, 0, 10),
    message: NotificationMessage.commentaire,
    user: john,
  ),
  Notifications(
    date: DateTime(2024, 01, 28, 12, 0, 0),
    message: NotificationMessage.rate,
    user: olivia,
  ),
  Notifications(
    date: DateTime(2024, 01, 28, 12, 0, 0),
    message: NotificationMessage.commentaire,
    user: james,
  ),
  Notifications(
    date: DateTime(2023, 12, 31, 18, 30, 45),
    message: NotificationMessage.rate,
    user: sam,
  ),
  Notifications(
    date: DateTime(2022, 12, 31, 18, 30, 45),
    message: NotificationMessage.commentaire,
    user: sophia,
  ),
  Notifications(
    date: DateTime(2021, 12, 30, 14, 45, 30),
    message: NotificationMessage.rate,
    user: greg,
  ),
  Notifications(
    date: DateTime(2024, 1, 26, 11, 0, 10),
    message: NotificationMessage.commentaire,
    user: john,
  ),
  Notifications(
    date: DateTime(2024, 01, 28, 12, 0, 0),
    message: NotificationMessage.rate,
    user: olivia,
  ),
  Notifications(
    date: DateTime(2024, 01, 28, 12, 0, 0),
    message: NotificationMessage.commentaire,
    user: james,
  ),
];
