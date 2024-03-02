import 'package:get/get.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';

validInput({
  required String val,
  required int min,
  required int max,
  required InputType type,
}) {
  if (type == InputType.userName) {
    if (!GetUtils.isUsername(val)) {
      return "not valid username";
    }
  }
  if (type == InputType.email) {
    if (!GetUtils.isEmail(val)) {
      return "not valid email";
    }
  }

  if (val.isEmpty) {
    return "can't be Empty";
  }

  if (val.length < min) {
    return "can't be less than $min";
  }

  if (val.length > max) {
    return "can't be larger than $max";
  }
}
