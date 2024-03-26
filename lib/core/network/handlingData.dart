import 'package:inbridge/core/network/networkHandler.dart';

handlingData(response) {
  if (response is StatusRequest) {
    print("response $response");
    return response;
  } else {
    return StatusRequest.success;
  }
}
