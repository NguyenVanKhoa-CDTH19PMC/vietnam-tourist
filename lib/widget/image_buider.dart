import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageBuilder extends StatefulWidget {
  final void Function()? onTap;
  final double? width;
  final double? height;
  final Widget? child;
  final String href;
  const ImageBuilder(
      {Key? key,
      this.onTap = null,
      this.width,
      this.height,
      this.child,
      required this.href});
  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () {},
      child: Container(
        height: widget.height ?? MediaQuery.of(context).size.width / 3,
        width: widget.width ?? MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.href),
            fit: BoxFit.cover,
          ),
        ),
        child: widget.child ?? null /* add child content here */,
      ),
    );
  }
}
