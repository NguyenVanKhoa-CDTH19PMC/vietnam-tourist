import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Color> _mainColor() {
  return [Colors.blue.shade500, Colors.blue.shade700, Colors.blue.shade800];
}

class IconButtonBuilder extends StatefulWidget {
  final Icon icon;
  final void Function()? onPressed;
  final double size;

  const IconButtonBuilder({
    Key? key,
    required this.icon,
    this.onPressed = null,
    this.size = 35,
  });
  @override
  _IconButtonBuilderState createState() => _IconButtonBuilderState();
}

class _IconButtonBuilderState extends State<IconButtonBuilder> {
  late String error = '';
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: _mainColor(),
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: IconButton(
        icon: widget.icon,
        onPressed: widget.onPressed ?? () {},
        iconSize: widget.size,
      ),
    );
  }
}
