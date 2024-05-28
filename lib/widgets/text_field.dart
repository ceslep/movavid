// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:movavid/api/api_laboratorio.dart';

class TextFieldI extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final Color? colort;
  final int? minLines;
  final int? maxLines;
  final bool? dropdown;
  final String? codexamen;
  const TextFieldI(
      {super.key,
      required this.labelText,
      required this.controller,
      this.colort = Colors.blue,
      this.minLines = 1,
      this.maxLines = 2,
      this.dropdown = false,
      this.codexamen = ''});

  @override
  State<TextFieldI> createState() => _TextFieldIState();
}

class _TextFieldIState extends State<TextFieldI> {
  List<DropDownValueModel> options = [];
  late SingleValueDropDownController _cnt;

  @override
  void initState() {
    super.initState();
    _cnt = SingleValueDropDownController();
    if (widget.dropdown!) {
      getItemsExamen(context, widget.codexamen!).then((value) {
        options = value.map((e) {
          return DropDownValueModel(value: e, name: e);
        }).toList();
        setState(() {});
      });
    }
  }

  Widget _buildTextFieldI(
      String labelText, TextEditingController controller, Color color) {
    String value = controller.text;
    value = value != 'null' ? value : '';
    controller.text = value;
    return !widget.dropdown!
        ? TextFormField(
            maxLines: null,
            minLines: widget.minLines,
            validator: (value) {
              if (value == '') return 'Falta el valor de este campo';
              return null;
            },
            onChanged: (value) {},
            controller: controller,
            decoration: InputDecoration(
              focusColor: Colors.lightBlue.shade100,
              labelText: labelText,
              labelStyle: const TextStyle(
                color: Colors.blueGrey,
              ),
            ),
            style: TextStyle(color: color),
          )
        : options.isNotEmpty
            ? DropDownTextField(
                controller: _cnt,
                clearOption: true,
                dropDownItemCount: options.length,
                dropDownList: options,
                onChanged: (value) {
                  if (value.value != "") {
                    controller.text = value.value.toString();
                  }
                },
              )
            : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextFieldI(
        widget.labelText, widget.controller, widget.colort!);
  }
}
