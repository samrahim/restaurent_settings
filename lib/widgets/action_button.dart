import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final void Function()? onPressed;
  final String text;
  const ActionButton({super.key, required this.onPressed, required this.text});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      child: Text(widget.text, style: TextStyle(color: Colors.red)),
    );
  }
}
