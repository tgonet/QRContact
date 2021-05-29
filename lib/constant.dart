import 'package:flutter/material.dart';

const Color primary = Color(0xFF3428D4);
const Color background = Color(0xFFF4F5F2);
const Color accent = Color(0xFFFFFFFF);
const Color cardBackground = Color(0xFFF7F7F7);
const Color textBox = Color(0xFFFAF8F8);

const TextStyle header = TextStyle(fontWeight: FontWeight.bold, fontSize: 21);

BoxDecoration textBoxDeco = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(color: Colors.grey, blurRadius: 2.0, spreadRadius: 0.4)
    ]);

BorderRadiusGeometry panelRadius = BorderRadius.only(
  topLeft: Radius.circular(24.0),
  topRight: Radius.circular(24.0),
);

Container panelCue = Container(
  width: 30,
  height: 5,
  decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.all(Radius.circular(12.0))),
);

List<DropdownMenuItem<String>> items = [
  DropdownMenuItem(
    child: Text("Work"),
    value: "Work",
  ),
  DropdownMenuItem(
    child: Text("School"),
    value: "School",
  ),
  DropdownMenuItem(
    child: Text("Test"),
    value: "Test",
  )
];

class myPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = primary;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.lineTo(size.width, 0);
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 1.2);
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.4, size.width, size.height * 0.6);

    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
