import 'package:flutter/material.dart';
import 'package:movavid/models/data-hemat.dart';

class Hemograma {
  final String title;
  final String value;
  final String referenceRange;

  Hemograma(this.title, this.value, this.referenceRange);

  factory Hemograma.fromJson(Map<String, String> json) {
    return Hemograma(
      json['title']!,
      json['value']!,
      json['referenceRange']!,
    );
  }
}

class VerImportacion extends StatelessWidget {
  final DataHemat data;
  const VerImportacion({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<Hemograma> hemogramas = [];
    Map<String, dynamic> dataH = data.toJson();
    for (var entry in dataH.entries) {
      String title = entry.key;
      String values = entry.value ?? '';
      String value = '';
      String referenceRange = '';
      if (values != '') {
        value = values.split('Ref.')[0];
        referenceRange = values.split('Ref.')[1];
      }
      hemogramas.add(Hemograma.fromJson(
          {'title': title, 'value': value, 'referenceRange': referenceRange}));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Datos Importados Rayto',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
      body: gridHemat(context, hemogramas, data),
    );
  }
}

Decoration _buildDecoration() {
  return const BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.black, width: 1.0),
      left: BorderSide(color: Colors.black, width: 1.0),
      right: BorderSide(color: Colors.black, width: 1.0),
      bottom: BorderSide(color: Colors.black, width: 1.0),
    ),
  );
}

Widget gridHemat(
    BuildContext context, List<Hemograma> hemogramas, DataHemat data) {
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Tres columnas
        mainAxisExtent: 30,
        crossAxisSpacing: 10,
      ),
      itemCount: hemogramas.length + 1,
      itemBuilder: (context, index) {
        int indexx = index - 1;
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Importado a través del Servidor 127.0.0.1:3000'),
          );
        } else {
          final hemograma = hemogramas[indexx];

          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              decoration: _buildDecoration(),
              child: Row(
                children: [
                  Container(
                    decoration: _buildDecoration(),
                    child: SizedBox(
                      width: 60,
                      child: Text(
                        hemograma.title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: _buildDecoration(),
                    child: SizedBox(
                      width: 150,
                      child: Text(
                        hemograma.value,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    decoration: _buildDecoration(),
                    child: SizedBox(
                      width: 184,
                      child: Text(
                        hemograma.referenceRange,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
}
