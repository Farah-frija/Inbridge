/*import 'package:flutter/material.dart';

class ProfileStack extends StatelessWidget {
  const ProfileStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
                              CircleAvatar(
                                radius: 80.0,
                                backgroundImage: _imageFile == null
                                    ? NetworkImage(_image)
                                        as ImageProvider<Object>?
                                    : FileImage(_imageFile!)
                                        as ImageProvider<Object>?,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 20.0,
                                child: InkWell(
                                  onTap: () {
                                    camera.onpressed(context);
                                  },
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.teal,
                                    size: 28.0,
                                  ),
                                ),
                              ),
                            ]),
  }
}*/
