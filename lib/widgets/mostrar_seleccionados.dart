import 'package:flutter/material.dart';
import 'package:movavid/models/procedimientos_model.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final List<Procedimientos> seleccionados;
  final List<Widget> actions;

  const CustomAlertDialog({
    required Key key,
    required this.title,
    required this.seleccionados,
    required this.actions,
  }) : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Text(widget.title),
          const Icon(
            Icons.person,
            color: Colors.blue,
          ),
        ],
      ),
      content: ListView.builder(
        itemBuilder: (context, index) => Card(
          elevation: 2,
          borderOnForeground: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(widget.seleccionados[index].nombre!),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ),
      ),
      actions: widget.actions,
    );
  }
}
