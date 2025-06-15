import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class ButtonSupprimer extends StatefulWidget {
  final void Function()? onTap;
  const ButtonSupprimer({super.key, required this.onTap});

  @override
  State<ButtonSupprimer> createState() => _ButtonSupprimerState();
}

class _ButtonSupprimerState extends State<ButtonSupprimer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text('Supprimer', style: AppTextStyle.redsubHeading),
          ),
        ),
      ),
    );
  }
}
