import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class ButtonSupprimer extends StatefulWidget {
  void Function()? onTap;
  ButtonSupprimer({super.key, required this.onTap});

  @override
  State<ButtonSupprimer> createState() => _ButtonSupprimerState();
}

class _ButtonSupprimerState extends State<ButtonSupprimer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text('Supprimer', style: AppTextStyle.redsubHeading),
        ),
      ),
    );
  }
}
