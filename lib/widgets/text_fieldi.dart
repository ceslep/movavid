import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

extension StringExtension on String {
  String onlyNumbers() {
    return replaceAll(RegExp('[^0-9]'), '');
  }
}

bool validarCorreo(String correo) {
  if (correo == '') return false;
  final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );
  return emailRegExp.hasMatch(correo);
}

// ignore: must_be_immutable
class TextFieldi extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final int count;
  final Color color;
  final String hintText;
  final String field;
  final Function(String) onChanged;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final bool digitsOnly;
  final bool isCorreo;
  final bool autoFocus;
  int fieldiCount;
  bool correoValido;
  TextFieldi({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.count,
    required this.color,
    required this.hintText,
    required this.field,
    required this.onChanged,
    required this.textCapitalization,
    required this.keyboardType,
    required this.digitsOnly,
    this.isCorreo = false,
    this.autoFocus = false,
    this.fieldiCount = 0,
    this.correoValido = false,
  });

  @override
  State<TextFieldi> createState() => _TextFieldiState();
}

class _TextFieldiState extends State<TextFieldi> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final bool ok = widget.fieldiCount >= widget.count;
    final Color accent = widget.color;

    return TextField(
      onChanged: (value) {
        if (widget.isCorreo) {
          widget.correoValido = validarCorreo(widget.controller.text);
        }
        setState(() => widget.fieldiCount = value.length);
        widget.onChanged(value);
      },
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      controller: widget.controller,
      inputFormatters: [
        widget.digitsOnly
            ? FilteringTextInputFormatter.digitsOnly
            : !widget.isCorreo
                ? UpperCaseFormatter()
                : LowerCaseFormatter(),
      ],
      decoration: InputDecoration(
        error: widget.isCorreo
            ? Text(
                widget.correoValido ? 'Correo válido' : 'Correo inválido',
                style: TextStyle(
                  color: widget.correoValido ? scheme.primary : scheme.error,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              )
            : null,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: widget.correoValido ? scheme.primary : scheme.error,
          ),
        ),
        hintText: widget.hintText,
        label: Text(widget.field, style: TextStyle(color: accent)),
        counter: Text(
          widget.count > 0
              ? '${widget.fieldiCount.toString()} de Mínimo ${widget.count} Caracteres'
              : '',
          style: TextStyle(
            color: ok ? scheme.primary : scheme.error,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
    );
  }
}