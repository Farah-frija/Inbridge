/*import 'package:flutter/material.dart';
import 'package:inbridge/test/Models/User.dart';

class Project {
  String _photo;
  int _rates;
  DateTime _date; // Changed attribute name to 'date'
  User _user; // Added user attribute
  String _title;
  Project({
    required String photo,
    required int rates,
    required DateTime date, // Changed parameter name to 'date'
    required User user,
    required String title,
  })  : _photo = photo,
        _rates = rates,
        _date = date,
        _user = user,
        _title = title;

  String get photo => _photo;
  int get rates => _rates;
  DateTime get date => _date; // Changed getter name to 'date'
  User get user => _user;
  String get title => _title;

  String? calculateAndFormatTimeDifference() {
    if (_date != null) {
      DateTime now = DateTime.now();
      Duration difference = now.difference(_date!);

      if (difference.inSeconds < 60) {
        return (difference.inSeconds == 0)
            ? "Now"
            : "${difference.inSeconds}s ";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes}m ";
      } else if (difference.inHours < 24) {
        return "${difference.inHours}h ";
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

List<Project> projects = [
  Project(
      title: "project1",
      photo: 'path/to/photo1.jpg',
      rates: 5,
      date: DateTime(2023, 1, 15, 12, 30, 45),
      user: usersList[0]),
  Project(
      title: "project1",
      photo: 'path/to/photo2.jpg',
      rates: 3,
      date: DateTime(2023, 2, 20, 9, 15, 30),
      user: usersList[1]),
  Project(
      title: "project1",
      photo: 'path/to/photo3.jpg',
      rates: 4,
      date: DateTime(2023, 3, 25, 15, 45, 10),
      user: usersList[2]),
  Project(
      title: "project1",
      photo: 'path/to/photo4.jpg',
      rates: 2,
      date: DateTime(2023, 4, 10, 8, 0, 20),
      user: usersList[3]),
  Project(
      title: "project1",
      photo: 'path/to/photo5.jpg',
      rates: 5,
      date: DateTime(2023, 5, 5, 18, 30, 5),
      user: usersList[4]),
  Project(
      title: "project1",
      photo: 'path/to/photo6.jpg',
      rates: 3,
      date: DateTime(2023, 6, 18, 14, 20, 55),
      user: usersList[5]),
  Project(
      title: "project1",
      photo: 'path/to/photo7.jpg',
      rates: 4,
      date: DateTime(2023, 7, 30, 5, 0, 40),
      user: usersList[6]),
  Project(
      title: "project1",
      photo: 'path/to/photo8.jpg',
      rates: 2,
      date: DateTime(2023, 8, 12, 12, 45, 15),
      user: usersList[7]),
  Project(
      title: "project1",
      photo: 'path/to/photo9.jpg',
      rates: 5,
      date: DateTime(2023, 9, 8, 20, 10, 30),
      user: usersList[0]),
  Project(
      title: "project1",
      photo: 'path/to/photo10.jpg',
      rates: 3,
      date: DateTime(2023, 10, 22, 16, 5, 0),
      user: usersList[1]),
  // Add more projects as needed
];*/
