import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectDate(
    BuildContext context, TextEditingController controller) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1930),
    lastDate: DateTime(2225),
  );
  if (pickedDate != null) {
    controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }
}
