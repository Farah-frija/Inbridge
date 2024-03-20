import 'package:flutter/material.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/Icons/icons.dart';
import 'package:inbridge/core/constant/Themes/paddings/Paddings.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController? controller;

  MySearchBar({required this.controller, this.onchanged});
  Function(String)? onchanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onchanged,
      decoration: InputDecoration(
        contentPadding: kSearchPadding,
        filled: true,
        fillColor: KroseClair,
        prefixIcon: Icon(
          KSearchIcon,
          color: kwhite,
          size: 24,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            // Handle filter functionality here
          },
          child: KFilterIcon,
        ),
        hintText: 'Search',
        hintStyle: kSearchTextStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(KSearchRadius),
        ),
      ),
    );
  }
}
