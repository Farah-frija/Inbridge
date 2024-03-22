import 'dart:io';
import 'package:get/get.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';

bool validPhoto(File? photo) {
  return photo != null;
}

bool isValidDateOfBirth(DateTime dateOfBirth) {
  DateTime now = DateTime.now();

  int age = now.year -
      dateOfBirth.year -
      ((now.month > dateOfBirth.month ||
              (now.month == dateOfBirth.month && now.day >= dateOfBirth.day))
          ? 0
          : 1);

  return age >= 18 && age <= 80;
}

validInput({
  required String val,
  required int min,
  required int max,
  required InputType type,
}) {
  val = val.trim();
  if (val.isEmpty) {
    return "can't be Empty";
  } else {
    if (type == InputType.PhoneNumber) {
      if (!GetUtils.isNumericOnly(val)) {
        return "not valid phoneNumber";
      }
    }

    if (type == InputType.name) {
      if ((GetUtils.isNumericOnly(val))) {
        return "not valid name";
      }
    }
    if (type == InputType.FamilyName) {
      if ((GetUtils.isNumericOnly(val))) {
        return "not valid familyName";
      }
    }

    if (type == InputType.sexe) {}

    if (type == InputType.dateOfBirth) {
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
      if ((GetUtils.isNumericOnly(val))) {
        return "not valid username";
      }
    }
    if (type == InputType.dateOfBirth) {
      if (!GetUtils.isDateTime(val)) {
        return "not valid date of birth";
      }
    }
  }
}
