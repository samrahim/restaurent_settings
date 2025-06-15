import 'package:flutter/material.dart';
import 'package:restaurent/consts.dart';

class CustomListTile extends StatelessWidget {
  final String? leading;
  final String? trailing;
  final Widget? trailingwidget;
  final Widget? title;

  const CustomListTile({
    required this.trailingwidget,
    required this.title,
    super.key,
    required this.leading,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          leading != null
              ? Text(leading!, style: AppTextStyle.greyHeading)
              : null,
      trailing:
          trailing != null
              ? Text(trailing!, style: AppTextStyle.indingosubHeading)
              : trailingwidget,
      title: title,
    );
  }
}
