import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:ui' as ui;
import 'package:flutter_quill/flutter_quill.dart';

import 'package:get/get.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrawingPage(),
    );
  }
}

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  ui.Image? _image;

  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    ByteData data = await rootBundle.load('assets/images/meme.jpg');
    Uint8List bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo fi = await codec.getNextFrame();
    setState(() {
      _image = fi.image;
    });
  }

  List<Shape> shapes = [];

  void goBack() {
    setState(() {
      if (shapes.isNotEmpty) {
        shapes.removeLast();
      }
    });
  }

  void addShape(Shape shape) {
    setState(() {
      shapes.add(shape);
    });
  }

  void addTextWithDialog(Offset position) {
    TextEditingController textController = TextEditingController();
    Color selectedColor = Colors.black;
    double fontSize = 20.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Enter Text'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: textController,
                      decoration:
                          InputDecoration(hintText: 'Type your text here'),
                    ),
                    SizedBox(height: 20),
                    Text('Text Color:'),
                    ColorPicker(
                      pickerColor: kblack,
                      onColorChanged: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Font Size:'),
                    Slider(
                      value: fontSize,
                      min: 10.0,
                      max: 40.0,
                      divisions: 6,
                      label: fontSize.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          fontSize = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    setState(() {
                      addShape(TextData(position, textController.text,
                          selectedColor, fontSize));
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw Rectangles'),
      ),
      body: GestureDetector(
        onTapUp: (details) {
          addTextWithDialog(details.localPosition);
        },
        onPanStart: (details) {
          setState(() {
            shapes.add(Rectangle.fromPoints(
                details.localPosition, details.localPosition));
          });
        },
        onPanUpdate: (details) {
          setState(() {
            shapes[shapes.length - 1] = Rectangle.fromPoints(
                shapes[shapes.length - 1].topLeft, details.localPosition);
          });
        },
        onPanEnd: (details) {
          // Add finishing logic if needed
          // Set the last rectangle's paint color to transparent
          if (shapes.isNotEmpty && shapes.last is Rectangle) {
            print("hattou");
            Rectangle lastRectangle = shapes.last as Rectangle;

            print(lastRectangle.paint.color);
            // Redraw the canvas
            setState(() {
              lastRectangle.paint.color = Colors.transparent;
            });
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/temp1vide.png'),
                CustomPaint(
                  painter: DrawingPainter(
                    shapes,
                    _image,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: goBack,
              child: Icon(Icons.arrow_back),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Shape> shapes;
  final ui.Image? backgroundImage;

  DrawingPainter(this.shapes, this.backgroundImage);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw shapes
    for (var shape in shapes) {
      if (shape is Rectangle) {
        final rectanglePaint = shape.paint;
        canvas.drawRect(shape.rect, rectanglePaint);
      } else if (shape is TextData) {
        final textPaint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;

        final textSpan = TextSpan(
          text: shape.text,
          style: TextStyle(fontSize: 20, color: Colors.black),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        );

        textPainter.layout();
        textPainter.paint(
          canvas,
          shape.position -
              Offset(textPainter.width / 2, textPainter.height / 2),
        );
      }
    }

    // Draw background image
    if (backgroundImage != null) {
      final imageSize = Size(backgroundImage!.width.toDouble(),
          backgroundImage!.height.toDouble());
      final srcRect = Rect.fromLTWH(0, 0, imageSize.width, imageSize.height);

      for (var shape in shapes) {
        if (shape is Rectangle) {
          // Calculate scaling factor
          final scaleX = shape.rect.width / imageSize.width;
          final scaleY = shape.rect.height / imageSize.height;
          final scale = scaleX < scaleY ? scaleX : scaleY;

          // Calculate destination rectangle
          final destWidth = imageSize.width * scale;
          final destHeight = imageSize.height * scale;
          final destRect = Rect.fromCenter(
            center: shape.rect.center,
            width: destWidth,
            height: destHeight,
          );

          // Draw scaled image
          canvas.drawImageRect(backgroundImage!, srcRect, destRect, Paint());
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

abstract class Shape {
  Rect get rect;
  Offset get topLeft;
}

class TextData extends Shape {
  final Offset position;
  final String text;
  final Color color;
  final double fontSize;

  TextData(this.position, this.text, this.color, this.fontSize);

  @override
  Rect get rect => Rect.fromPoints(position, position);

  @override
  Offset get topLeft => position;
}

class Rectangle extends Shape {
  final Rect rect;
  final Paint paint; // Define a Paint object for the rectangle

  Rectangle(this.rect, {required this.paint});

  factory Rectangle.fromPoints(Offset p1, Offset p2) {
    return Rectangle(Rect.fromPoints(p1, p2),
        paint: Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0);
  }

  @override
  Offset get topLeft => rect.topLeft;
}
