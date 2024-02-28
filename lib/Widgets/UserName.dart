import 'package:flutter/cupertino.dart';
import 'package:inbridge/Themes/TextStyles/TextStyles.dart';

class UserName extends StatelessWidget {
  UserName({required this.username, required this.email});
  String username;
  String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(username, style: kuserName),
        SizedBox(height: 5),
        Text(email, style: kemail)
      ],
    );
  }
}
