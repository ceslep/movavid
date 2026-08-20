import 'package:flutter/material.dart';

class ExamActions extends StatelessWidget {
  final bool busy;
  final VoidCallback onPrint;
  final VoidCallback onSave;

  const ExamActions({
    super.key,
    required this.busy,
    required this.onPrint,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton.tonalIcon(
            onPressed: onPrint,
            icon: const Icon(Icons.print_rounded, size: 18),
            label: const Text('Imprimir'),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.save_rounded, size: 18),
            label: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}