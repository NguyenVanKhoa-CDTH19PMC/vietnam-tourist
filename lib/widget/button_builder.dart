import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Color> _mainColor() {
  return [Colors.blue.shade500, Colors.blue.shade700, Colors.blue.shade800];
}

class ButtonBuilder extends StatefulWidget {
  final String text;
  final void Function()? onPressed;

  const ButtonBuilder({
    Key? key,
    required this.text,
    this.onPressed,
  });
  @override
  _ButtonBuilderState createState() => _ButtonBuilderState();
}

class _ButtonBuilderState extends State<ButtonBuilder> {
  late String error = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: _mainColor(),
        ),
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed ?? () {},
        child: Text(
          widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onSurface: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: Size.fromHeight(40),
        ),
      ),
    );
  }
}
