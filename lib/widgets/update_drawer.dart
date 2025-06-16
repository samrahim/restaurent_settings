import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:restaurent/consts.dart';
import 'package:restaurent/widgets/create_button.dart';
import 'package:restaurent/widgets/show_picket.dart';

class UpdateAttributeDrawer extends StatefulWidget {
  final String label;
  final dynamic initialValue;
  final FieldType fieldType;
  final List<String>? options;
  final void Function(dynamic) onSaved;

  const UpdateAttributeDrawer({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.fieldType,
    this.options,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<UpdateAttributeDrawer> createState() => _UpdateAttributeDrawerState();
}

class _UpdateAttributeDrawerState extends State<UpdateAttributeDrawer> {
  late TextEditingController _controller;
  late bool _boolValue;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue?.toString() ?? '',
    );
    _boolValue = widget.initialValue == true || widget.initialValue == 'true';
    _selectedColor =
        widget.initialValue is Color
            ? widget.initialValue
            : Colors.blue; // Default color
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
                  labelText: 'Gestion du trop-perçu',
                ),

                value: widget.initialValue,
                items:
                    widget.options!
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
