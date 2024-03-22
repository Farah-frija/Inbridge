// import 'package:flutter/material.dart';
// import 'package:inbridge/test/Models/User.dart';
// import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
// import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
// import 'package:multiselect_dropdown_flutter/multiselect_dropdown_flutter.dart';

// class Multitest extends StatefulWidget {
//   const Multitest({super.key});

//   @override
//   State<Multitest> createState() => _MultitestState();
// }

// class _MultitestState extends State<Multitest> {
//   @override
//   List<User> myList = usersList;
//   String text = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             MultiSelectDropdown.simpleList(
//               includeSearch: true,
//               list: myList,
//               includeSelectAll: true,
//               initiallySelected: [],
//               checkboxFillColor: KroseClair,
//               splashColor: Colors.transparent,
//               numberOfItemsLabelToShow: 3,
//               textStyle: kemail,
//               listTextStyle: kemail,
//               whenEmpty: text,
//               onChange: (newList) {
//                 if (newList.length == myList.length) {
//                   setState(() {
//                     text = "toute la tunisie";
//                   });
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
