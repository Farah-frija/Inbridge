import 'package:flutter/material.dart';
import 'package:inbridge/Themes/Colors/colors.dart';
import 'package:inbridge/Themes/Icons/icons.dart';
import 'package:inbridge/Themes/paddings/Paddings.dart';
import 'package:inbridge/Themes/TextStyles/TextStyles.dart';

class MySearchBar extends StatefulWidget {
  final TextEditingController? controller;

  MySearchBar({required this.controller});

  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
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
          onTap: () {},
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
