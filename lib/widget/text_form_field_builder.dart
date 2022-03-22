import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFormBuilder extends StatefulWidget {
  final String initialValue;
  final bool enabled;

  final bool obscureText;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hintText;

  final TextEditingController? controller;
  final void Function(String)? onSaved, onChange;
  final String Function(String?)? validateFunction;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;

  const TextFormBuilder({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue = '',
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.onChange,
    this.validateFunction,
    this.onSaved,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.enabled = true,
  });
  @override
  _TextFormBuilderState createState() => _TextFormBuilderState();
}

class _TextFormBuilderState extends State<TextFormBuilder> {
  late String error = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 15, bottom: 0),
          child: Theme(
            data: ThemeData(
              primaryColor: Theme.of(context).accentColor,
              accentColor: Theme.of(context).accentColor,
            ),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              // initialValue: widget.initialValue,
              enabled: widget.enabled,
              onChanged: widget.onChange,
              style: TextStyle(
                fontSize: 15.0,
              ),
              key: widget.key,
              controller: widget.controller ?? null,
              obscureText: widget.obscureText,
              keyboardType: widget.textInputType,
              validator: widget.validateFunction ?? null,
              onSaved: (val) {
                // error = widget.validateFunction(val);
                // setState(() {});
                // widget.onSaved(val);
              },
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              onFieldSubmitted: widget.onFieldSubmitted,
              decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          size: 15.0,
                        )
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? Icon(
                          widget.suffixIcon,
                          size: 15.0,
                        )
                      : null,
                  fillColor: Colors.white,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 0.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                      color: error.isEmpty ? Colors.white : Colors.red.shade700,
                      width: 0.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                      color: error.isEmpty
                          ? Theme.of(context).accentColor
                          : Colors.red.shade700,
                      width: 1.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(
                      color: Colors.red.shade700,
                      width: 1.0,
                    ),
                  ),
                  errorStyle: TextStyle(height: 0.0, fontSize: 0.0)),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: error.isEmpty ? Colors.black45 : Colors.red.shade700,
                )
              ]),
        ),
        Visibility(
          visible: Error != '',
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20.0, top: 3),
            child: Text(
              error,
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
