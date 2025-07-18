import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

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
      } else {
        _selectedChoices =
            widget.initialValue != null
                ? List<String>.from(widget.initialValue)
                : <String>[];
      }
    }
  }

  List<int> _pattern = [];

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
                  activeColor: AppColors.primary,

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
                            child: Text(e.toString()),
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
                    SizedBox(),
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
                    SizedBox(),
                  ],
                ),
              )
            else if (widget.fieldType == FieldType.choice)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Wrap(
                  spacing: 8,
                  children:
                      widget.options!.map((option) {
                        if (option is SalleModel) {
                          final int id = option.id;
                          final String label = option.nom;
                          final bool isSelected = _selectedChoices.contains(id);
                          return ChoiceChip(
                            label: Text(label),
                            selected: isSelected,
                            selectedColor: AppColors.indingo200,
                            onSelected: (selected) {
                              setState(() {
                                if (option.nom == 'Toutes') {
                                  if (selected) {
                                    _selectedChoices = [option.id];
                                  } else {
                                    _selectedChoices.remove(option.id);
                                  }
                                } else if (option is SalleModel) {
                                  if (selected) {
                                    _selectedChoices =
                                        _selectedChoices
                                            .where(
                                              (id) =>
                                                  id !=
                                                  widget.options!
                                                      .firstWhere(
                                                        (s) =>
                                                            s is SalleModel &&
                                                            s.nom == 'Toutes',
                                                      )
                                                      .id,
                                            )
                                            .toList();
                                    _selectedChoices.add(option.id);
                                  } else {
                                    _selectedChoices.remove(option.id);
                                  }
                                } else {
                                  if (selected) {
                                    _selectedChoices.add(option.toString());
                                  } else {
                                    _selectedChoices.remove(option.toString());
                                  }
                                }
                              });
                            },
                          );
                        } else {
                          final String value = option.toString();
                          final bool isSelected = _selectedChoices.contains(
                            value,
                          );
                          return ChoiceChip(
                            label: Text(value),
                            selected: isSelected,
                            selectedColor: AppColors.indingo200,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedChoices.add(value);
                                } else {
                                  _selectedChoices.remove(value);
                                }
                              });
                            },
                          );
                        }
                      }).toList(),
                ),
              )
            else
              Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
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
                  case FieldType.boolean:
                    widget.onSaved(_boolValue);
                    break;
                  case FieldType.color:
                    widget.onSaved(_selectedColor);
                    break;
                  case FieldType.dropdown:
                  case FieldType.string:
                    widget.onSaved(_controller.text);
                    break;
                  case FieldType.pattern:
                    widget.onSaved(_pattern.join(''));
                    break;
                  case FieldType.choice:
                    widget.onSaved(_selectedChoices);
                    break;
                }
                Navigator.of(context).pop();
              },
              buttonText: "Sauvgarder",
            ),
          ],
        ),
      ),
    );
  }
}
