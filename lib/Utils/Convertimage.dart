import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart';

Future<File> ConvertImage(String path) async {
  var bytes = await rootBundle.load(path);
  String tempPath = (await getTemporaryDirectory()).path;
  File file = File('$tempPath/profile.png');
  await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

  return file;
}
