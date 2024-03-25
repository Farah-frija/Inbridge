import 'dart:typed_data';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
    ByteData data = await rootBundle.load('assets/images/sbou3imeme.png');
    Uint8List bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo fi = await codec.getNextFrame();
    setState(() {
      _image = fi.image;
    });
  }

  List<Rect> rectangles = [];
  void goBack() {
    setState(() {
      if (rectangles.isNotEmpty) {
        rectangles.removeLast();
      }
    });
  }

  final String imagePath = 'assets/images/meme.jpg';
  late ui.Image image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw Rectangles'),
      ),
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            rectangles.add(
                Rect.fromPoints(details.localPosition, details.localPosition));
          });
        },
        onPanUpdate: (details) {
          setState(() {
            rectangles[rectangles.length - 1] = Rect.fromPoints(
                rectangles[rectangles.length - 1].topLeft,
                details.localPosition);
          });
        },
        onPanEnd: (details) {
          // Add finishing logic if needed
        },
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/sbou3i.png'),
                CustomPaint(
                    painter: RectanglePainter(
                  rectangles,
                  _image,
                )),
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

class RectanglePainter extends CustomPainter {
  final List<Rect> rectanles;
  final ui.Image? backgroundImage;

  RectanglePainter(this.rectanles, this.backgroundImage);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw rectangles
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    for (var rectangle in rectanles) {
      canvas.drawRect(rectangle, paint);

      // Draw background image scaled to fit the rectangle
      if (backgroundImage != null) {
        final imageSize = Size(backgroundImage!.width.toDouble(),
            backgroundImage!.height.toDouble());
        final srcRect = Rect.fromLTWH(0, 0, imageSize.width, imageSize.height);

        // Calculate scaling factor
        final scaleX = rectangle.width / imageSize.width;
        final scaleY = rectangle.height / imageSize.height;
        final scale = scaleX < scaleY ? scaleX : scaleY;

        // Calculate destination rectangle
        final destWidth = imageSize.width * scale;
        final destHeight = imageSize.height * scale;
        final destRect = Rect.fromCenter(
          center: rectangle.center,
          width: destWidth,
          height: destHeight,
        );

        // Draw scaled image
        canvas.drawImageRect(backgroundImage!, srcRect, destRect, Paint());
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///////////////////////////////////////////////////////////////////////////////////////
///import 'package:flutter/material.dart';
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
    ByteData data = await rootBundle.load('assets/images/sbou3imeme.png');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Draw Rectangles'),
      ),
      body: GestureDetector(
        onTapUp: (details) {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final localPosition = renderBox.globalToLocal(details.globalPosition);
          addShape(TextData(localPosition, "Sample Text"));
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
        },
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/sbou3i.png'),
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
        final rectanglePaint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
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

class Rectangle extends Shape {
  final Rect rect;

  Rectangle(this.rect);

  factory Rectangle.fromPoints(Offset p1, Offset p2) {
    return Rectangle(Rect.fromPoints(p1, p2));
  }

  @override
  Offset get topLeft => rect.topLeft;
}

class TextData extends Shape {
  final Offset position;
  final String text;

  TextData(this.position, this.text);

  @override
  Rect get rect => Rect.fromPoints(position, position);

  @override
  Offset get topLeft => position;
}
_________________________________________________________________
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  Color _textColor = Colors.black;
  double _fontSize = 20.0;
  FontWeight _fontWeight = FontWeight.normal;
  String _fontFamily = 'Roboto';

  ui.Image? _image;

  void initState() {
    super.initState();
    loadImage();
  }

  Future<void> loadImage() async {
    ByteData data = await rootBundle.load('assets/images/sbou3imeme.png');
    Uint8List bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes);
    ui.FrameInfo fi = await codec.getNextFrame();
    setState(() {
      _image = fi.image;
    });
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _textColor,
              onColorChanged: (color) {
                setState(() => _textColor = color);
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
        );
      },
    );
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

  void _showTextPropertiesPanel() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Text Properties',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Text('Color:'),
                  SizedBox(width: 10.0),
                  IconButton(
                    onPressed: () {
                      _showColorPicker();
                    },
                    icon: Icon(Icons.color_lens),
                    color: _textColor,
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Font Size:'),
                  SizedBox(width: 10.0),
                  Slider(
                    min: 10.0,
                    max: 50.0,
                    value: _fontSize,
                    onChanged: (value) {
                      setState(() {
                        _fontSize = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Font Weight:'),
                  SizedBox(width: 10.0),
                  DropdownButton<FontWeight>(
                    value: _fontWeight,
                    onChanged: (value) {
                      setState(() {
                        _fontWeight = value!;
                      });
                    },
                    items: FontWeight.values.map((FontWeight weight) {
                      return DropdownMenuItem<FontWeight>(
                        value: weight,
                        child: Text(weight.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Font Family:'),
                  SizedBox(width: 10.0),
                  DropdownButton<String>(
                    value: _fontFamily,
                    onChanged: (value) {
                      setState(() {
                        _fontFamily = value!;
                      });
                    },
                    items: [
                      'Roboto',
                      'Arial',
                      'Times New Roman',
                      'Courier New',
                    ].map((String fontFamily) {
                      return DropdownMenuItem<String>(
                        value: fontFamily,
                        child: Text(fontFamily),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void addTextWithDialog(Offset position) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Text'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Type your text here'),
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
                addShape(TextData(position, controller.text));
                Navigator.of(context).pop();
              },
            ),
          ],
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
        onLongPress: () {
          _showTextPropertiesPanel();
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
        },
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/sbou3i.png'),
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
        final rectanglePaint = Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
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

class Rectangle extends Shape {
  final Rect rect;

  Rectangle(this.rect);

  factory Rectangle.fromPoints(Offset p1, Offset p2) {
    return Rectangle(Rect.fromPoints(p1, p2));
  }

  @override
  Offset get topLeft => rect.topLeft;
}

class TextData extends Shape {
  final Offset position;
  final String text;

  TextData(this.position, this.text);

  @override
  Rect get rect => Rect.fromPoints(position, position);

  @override
  Offset get topLeft => position;
}
______________________________________________________________________________
