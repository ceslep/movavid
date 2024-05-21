import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  final String title;
  final String asset;
  const ModalFit({super.key, required this.title, required this.asset});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Row(
        children: [
          SizedBox(
            width: 0.2 * MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 36,
                backgroundImage: AssetImage(asset),
              ),
            ),
          ),
          SizedBox(
            width: 0.6 * MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Aceptar',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
