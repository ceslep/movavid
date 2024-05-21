import 'package:flutter/material.dart';
import 'package:movavid/models/paciente.dart';

PreferredSizeWidget appBarExam(
  BuildContext context,
  Paciente paciente,
  String fecha,
  final VoidCallback? onPrint,
  final VoidCallback? onSave,
  bool guardando_,
  Color backgroundColor,
  Color frontColor,
) {
  return AppBar(
    backgroundColor: backgroundColor,
    foregroundColor: frontColor,
    title: Text(
      'Registro de Exámenes',
      style: TextStyle(
        fontSize: 14,
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: !guardando_
            ? IconButton(
                onPressed: onPrint,
                icon: const Icon(
                  Icons.print,
                  color: Colors.white,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: 13,
                  height: 13,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: !guardando_
            ? IconButton(
                onPressed: onSave,
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: 13,
                  height: 13,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              ),
      ),
    ],
  );
}
