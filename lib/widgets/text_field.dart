// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/widgets/editable_drop_down.dart';

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
  List<String> soptions = [];
  FocusNode fnode = FocusNode();

  @override
  void initState() {
    super.initState();
    fnode.addListener(
      () {},
    );
    if (widget.dropdown!) {
      getItemsExamen(context, widget.codexamen!).then((value) {
        soptions = value;

        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
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
        : soptions.isNotEmpty
            ? EditableDropdown(
                controller: widget.controller,
                options: soptions,
              )
            : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTextFieldI(
        widget.labelText, widget.controller, widget.colort!);
  }
}

/* 
DropDownTextField(
                textFieldFocusNode: fnode,
                textFieldDecoration: const InputDecoration(
                  hintText: 'Seleccione el valor',
                ),
                controller: _cnt,
                dropDownList: options,
                dropDownItemCount: options.length + 1,
                onChanged: (val) {
                  try {
                    print({"-->": val});
                    controller.text = val.value.toString();
                    setState(() {});
                  } catch (e) {
                    print(e);
                  }
                },
              ) */