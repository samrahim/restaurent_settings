import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class ButtonSupprimer extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final TextStyle? style;

  const ButtonSupprimer({
    super.key,
    required this.onTap,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style:
                  style ??
                  AppTextStyle.redsubHeading.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
