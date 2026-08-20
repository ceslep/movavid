import 'package:flutter/material.dart';
import 'package:movavid/api/api_laboratorio.dart';

class ConnectionBanner extends StatelessWidget {
  const ConnectionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: serverDown,
      builder: (context, down, _) {
        if (!down) return const SizedBox.shrink();
        return Material(
          color: const Color(0xFFB3261E),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off_rounded,
                      size: 18, color: Colors.white),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Sin conexión con el servidor. Verifique su red o la URL en Configuración.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => serverDown.value = false,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Entendido'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}