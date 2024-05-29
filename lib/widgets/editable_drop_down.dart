import 'package:flutter/material.dart';

class EditableDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;
  const EditableDropdown(
      {super.key, required this.controller, required this.options});

  @override
  State<EditableDropdown> createState() => _EditableDropdownState();
}

class _EditableDropdownState extends State<EditableDropdown> {
  final List<String> _items = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry'
  ];

  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: 'Valoración',
              suffixIcon: DropdownButton<String>(
                value: _selectedItem,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedItem = newValue;
                    widget.controller.text = newValue!;
                  });
                },
                items: widget.options
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _selectedItem = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
