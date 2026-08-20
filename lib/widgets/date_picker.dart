import 'package:flutter/material.dart';
import 'package:movavid/functions/select_date.dart';

Widget buildDatePicker(
    BuildContext context, TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      hintText: 'Seleccione una fecha',
      prefixIcon: Icon(
        Icons.event_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          selectDate(context, controller);
        },
        icon: const Icon(Icons.calendar_month_rounded),
        tooltip: 'Seleccionar fecha',
      ),
    ),
  );
}