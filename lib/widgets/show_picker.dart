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
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Center(
              child: Text('Sélectionner la couleur de la catégorie'),
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: tempColor,
                onColorChanged: (Color color) {
                  setState(() {
                    tempColor = color;
                  });
                },
                enableAlpha: false,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Annuler'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: const Text('Sélectionner'),
                onPressed: () {
                  Navigator.of(context).pop();
                  onColorSelected(tempColor);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
