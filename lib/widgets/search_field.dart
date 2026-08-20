import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hint;
  final bool autofocus;
  final String? label;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hint = 'Buscar...',
    this.autofocus = false,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      autofocus: autofocus,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13),
          child: Icon(Icons.search_rounded, color: scheme.primary, size: 22),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
            onChanged('');
          },
          icon: Icon(Icons.close_rounded, color: scheme.onSurfaceVariant),
          tooltip: 'Limpiar',
        ),
      ),
    );
  }
}