import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/models/models.dart';
import 'package:restaurent/widgets/widgets.dart';

class UpdateAttributeDrawer extends StatefulWidget {
  final String label;
  final dynamic initialValue;
  final FieldType fieldType;
  final List<dynamic>? options;
  final void Function(dynamic) onSaved;

  const UpdateAttributeDrawer({
    super.key,
    required this.label,
    required this.initialValue,
    required this.fieldType,
    this.options,
    required this.onSaved,
  });

  @override
  State<UpdateAttributeDrawer> createState() => _UpdateAttributeDrawerState();
}

class _UpdateAttributeDrawerState extends State<UpdateAttributeDrawer> {
  late TextEditingController _controller;
  late bool _boolValue;
  late Color _selectedColor;
  late List<dynamic> _selectedChoices;
  AffectationMode? _selectedAffectationMode;

  // Keep date as string formatted yyyy-MM-dd
  late String _dateString;

  List<int> _pattern = [];

  @override
  void initState() {
    super.initState();

    if (widget.fieldType == FieldType.datePicker) {
      // Normalize initial date value
      try {
        final dt = DateTime.parse(widget.initialValue);
        _dateString =
            "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
      } catch (e) {
        final parts = widget.initialValue.toString().split('-');
        if (parts.length == 3) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1].padLeft(2, '0'));
          final day = int.parse(parts[2].padLeft(2, '0'));
          _dateString =
              "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
        } else {
          final now = DateTime.now();
          _dateString =
              "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
        }
      }
    }

    _controller = TextEditingController(
      text: widget.initialValue?.toString() ?? '',
    );
    _boolValue = widget.initialValue == true || widget.initialValue == 'true';
    _selectedColor =
        widget.initialValue is Color ? widget.initialValue : Colors.blue;

    if (widget.fieldType == FieldType.choice) {
      if (widget.options != null &&
          widget.options!.isNotEmpty &&
          widget.options!.first is SalleModel) {
        _selectedChoices =
            widget.initialValue != null
                ? List<int>.from(widget.initialValue)
                : <int>[];

        if (widget.label == 'salle') {
          _selectedAffectationMode = AffectationMode.POUR_SEULEMENT;
        }
      } else {
        _selectedChoices =
            widget.initialValue != null
                ? List<String>.from(widget.initialValue)
                : <String>[];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .33,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Modifier ${widget.label}', style: AppTextStyle.greyHeading),
            const SizedBox(height: 16),

            if (widget.fieldType == FieldType.boolean)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greyaccent!, width: .9),
                ),
                child: SwitchListTile(
                  activeColor: AppColors.indingo400,
                  title: Text('Activer ?', style: AppTextStyle.greysubHeading),
                  value: _boolValue,
                  onChanged: (v) => setState(() => _boolValue = v),
                ),
              )
            else if (widget.fieldType == FieldType.dropdown)
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.greyaccent!),
                  ),
                  labelText: widget.label,
                ),
                value: widget.initialValue,
                items:
                    widget.options!
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e.toString(),
                            child: Text(
                              e.toString(),
                              style: AppTextStyle.indingosubHeading,
                            ),
                          ),
                        )
                        .toList(),
                onChanged: (val) => _controller.text = val!,
              )
            else if (widget.fieldType == FieldType.color)
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      openColorPicker(
                        context: context,
                        currentColor: _selectedColor,
                        onColorSelected: (Color color) {
                          setState(() {
                            _selectedColor = color;
                          });
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black26),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Cliquez pour choisir une couleur',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            else if (widget.fieldType == FieldType.pattern)
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: PatternLock(
                        dimension: 3,
                        showInput: true,
                        selectedColor: Colors.blue,
                        notSelectedColor: Colors.grey,
                        pointRadius: 8,
                        onInputComplete: (List<int> input) {
                          setState(() => _pattern = input);
                        },
                      ),
                    ),
                  ],
                ),
              )
            else if (widget.fieldType == FieldType.datePicker)
              TextFormField(
                controller: TextEditingController(text: _dateString),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.calendar,
                    context: context,
                    initialDate: DateTime.parse(_dateString),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && context.mounted) {
                    setState(() {
                      _dateString =
                          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                readOnly: true,
              )
            else if (widget.fieldType == FieldType.choice)
              // ... (your choice code unchanged)
              Container() // <-- keep your existing choice implementation here
            else
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.greyaccent!, width: .9),
                ),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    labelStyle: AppTextStyle.greyHeading,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

            const Spacer(),
            CreateButton(
              onPressed: () {
                switch (widget.fieldType) {
                  case FieldType.datePicker:
                    widget.onSaved(_dateString);
                    break;
                  case FieldType.boolean:
                    widget.onSaved(_boolValue);
                    break;
                  case FieldType.color:
                    widget.onSaved(
                      '#${colorToHex(_selectedColor).toString().toLowerCase()}',
                    );
                    break;
                  case FieldType.dropdown:
                  case FieldType.string:
                    widget.onSaved(_controller.text);
                    break;
                  case FieldType.pattern:
                    widget.onSaved(_pattern.join(''));
                    break;
                  case FieldType.choice:
                    if (widget.label == 'salle') {
                      widget.onSaved({
                        'choices': _selectedChoices,
                        'affectationMode':
                            _selectedAffectationMode ??
                            AffectationMode.POUR_SEULEMENT,
                      });
                    } else {
                      widget.onSaved(_selectedChoices);
                    }
                    break;
                }
                Navigator.of(context).pop();
              },
              buttonText: "Sauvegarder",
            ),
          ],
        ),
      ),
    );
  }
}
