import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void openColorPicker({
  required BuildContext context,
  required Color currentColor,
  required void Function(Color) onColorSelected,
}) {
  showDialog(
    context: context,
    builder: (_) {
      Color tempColor = currentColor;
      return AlertDialog(
        title: Center(child: Text('Selectioner la couleur de la categorie')),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: tempColor,
            onColorChanged: (Color color) {
              tempColor = color;
            },
            enableAlpha: false,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Select'),
            onPressed: () {
              Navigator.of(context).pop();
              onColorSelected(tempColor);
            },
          ),
        ],
      );
    },
  );
}
