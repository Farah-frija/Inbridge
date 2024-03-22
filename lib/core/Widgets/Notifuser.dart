// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
// import 'package:inbridge/test/modules/notification/model/Notification.dart';
// import 'package:inbridge/test/Models/User.dart';
// import 'package:inbridge/core/constant/Themes/Colors/colors.dart';

// import 'package:inbridge/core/Widgets/CircleAvatar.dart';

// class UserNotfication extends StatefulWidget {
//   UserNotfication({required this.notification});
//   Notifications notification;
//   @override
//   State<UserNotfication> createState() => _UserNotficationState();
// }

// class _UserNotficationState extends State<UserNotfication> {
//   late User? _user;
//   late File? _image;
//   late String? _name;
//   late String? _text;
//   late String? _time;

//   @override
//   void initState() {
//     super.initState();
//     _user = widget.notification.user;
//     _image = _user!.photo;
//     _name = _user!.userName;
//     _text = widget.notification.text;
//     _time = widget.notification.calculateAndFormatTimeDifference();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
//       child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         _ProfileImage(image: _image),
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10, top: 3),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Adjust the spacing between the icon and text
//                     Text(_name ?? "default name", style: ktitleName),

//                     Icon(
//                       Icons.more_horiz,
//                       color: kblue,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(_text ?? "default text", style: ksubtitle),
//                     Text(_time ?? "...", style: ksubtitle),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }

// class _ProfileImage extends StatelessWidget {
//   _ProfileImage({required this.image});
//   File? image;
// //todo prend comme parametres File image
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Avatar(
//           image: true,
//           photo: image,
//           radius: 25,
//           border: false,
//         ),
//         Positioned(
//             right: 5,
//             bottom: 0,
//             child: Avatar(
//               image: false,
//               border: false,
//               color: KroseClair,
//               radius: 8,
//             )),
//       ],
//     );
//   }
// }
