import 'dart:io';
import 'package:get/get.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';

bool validPhoto(File? photo) {
  return photo != null;
}

validInput({
  required String val,
  required int min,
  required int max,
  required InputType type,
}) {
  if (val.isEmpty) {
    return "can't be Empty";
  } else {
    if (type == InputType.PhoneNumber) {
      if (!GetUtils.isPhoneNumber(val)) {
        return "not valid phoneNumber";
      }
    }
    if (type == InputType.password) {
      /*if (!GetUtils.pas(val)) {
      return "not valid phoneNumber";*/
    }

    if (type == InputType.cin) {}
    if (type == InputType.name) {
      if (!GetUtils.isAlphabetOnly(val)) {
        return "not valid username";
      }
    }
    if (type == InputType.FamilyName) {
      if (!GetUtils.isAlphabetOnly(val)) {
        return "not valid username";
      }
    }
    if (type == InputType.institute) {
      //todo institute
    }
    if (type == InputType.sexe) {
      //todo choix
    }
    if (type == InputType.diplome) {
      //todo choix
    }
    if (type == InputType.dob) {
      if (!GetUtils.isDateTime(val)) {
        return "not valid username";
      }
    }
    if (type == InputType.email) {
      if (!GetUtils.isEmail(val)) {
        return "not valid email";
      }
    }

    if (val.length < min) {
      return "can't be less than $min";
    }

    if (val.length > max) {
      return "can't be larger than $max";
    }
    if (type == InputType.userName) {
      if (!GetUtils.isUsername(val)) {
        return "not valid username";
      }
    }
  }
}
