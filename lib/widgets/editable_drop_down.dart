// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class EditableDropdown extends StatefulWidget {
  final TextEditingController controller;
  final List<String> options;
  final String codexamen;
  final String nombreExamen;
  const EditableDropdown(
      {super.key,
      required this.controller,
      required this.options,
      required this.codexamen,
      required this.nombreExamen});

  @override
  State<EditableDropdown> createState() => _EditableDropdownState();
}

class _EditableDropdownState extends State<EditableDropdown> {
  late String? _selectedItem;
  final List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.controller.text;
    for (var i = 0; i < widget.options.length; i++) {
      var controller = TextEditingController(text: widget.options[i]);
      controller.addListener(() {
        print('Text in field $i changed to: ${controller.text}');
      });
      controllers.add(controller);
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              TextFormField(
                controller: widget.controller,
                style: const TextStyle(fontSize: 12),
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
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 8,
                          ),
                        ),
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
              Positioned(
                left: 52,
                top: -5,
                child: IconButton(
                  onPressed: () {
                    setItems(context);
                  },
                  icon: const Icon(Icons.settings,
                      size: 20, color: Color.fromARGB(255, 6, 112, 10)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> setItems(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('Modificar Items de ${widget.nombreExamen}'),
          content: Form(
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.options.length,
                itemBuilder: (BuildContext context, int index) {
                  return widget.options[index] != ''
                      ? ListTile(
                          title: Row(
                            children: [
                              SizedBox(
                                width: 0.6 * MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller: controllers[index],
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
