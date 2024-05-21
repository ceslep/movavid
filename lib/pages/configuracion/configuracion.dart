// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/configuracion_model.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';
import 'package:movavid/widgets/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Fimage {
  File fileImg;
  String fileImgStr64;
  Fimage(
    this.fileImg,
    this.fileImgStr64,
  );

  ImageProvider<Object>? get imageProvider {
    if (fileImgStr64 != '') {
      try {
        final bytes =
            base64Decode(fileImgStr64); // Use ! for non-null assertion
        return MemoryImage(bytes);
      } catch (error) {
        print('Error decoding image: $error');
        return null; // Or return a default image provider
      }
    } else {
      return null; // Or return a default image provider
    }
  }
}

class Configuracion extends StatefulWidget {
  const Configuracion({super.key});

  @override
  State<Configuracion> createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  bool cargando = false;
  bool guardando = false;
  FToast fToast = FToast();
  Color colort = Colors.amber;
  ConfiguracionModel configuracion = ConfiguracionModel();
  late final TextEditingController nitLaboratorioController =
      TextEditingController();
  late final TextEditingController nombreLaboratorioController =
      TextEditingController();
  late final TextEditingController direccionLaboratorioController =
      TextEditingController();
  late final TextEditingController telefonosLaboratorioController =
      TextEditingController();
  late final TextEditingController correoLaboratorioController =
      TextEditingController();
  late final TextEditingController webLaboratorioController =
      TextEditingController();
  late final TextEditingController bacteriologoLaboratorioController =
      TextEditingController();

  late final TextEditingController tarjetaPLaboratorioController =
      TextEditingController();

  late final TextEditingController urlFirmaLaboratorioController =
      TextEditingController();
  late final TextEditingController urlLogoLaboratorioController =
      TextEditingController();

  String imageFirma = '';
  String imageLogo = '';

  File? fimageFirma;
  Uint8List uil = Uint8List(0);
  Fimage fimage = Fimage(File(''), '');
  Fimage fimageLogo = Fimage(File(''), '');

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    setState(
      () => cargando = !cargando,
    );
    try {
      getConfiguracion(context).then((value) {
        configuracion = value;
        nitLaboratorioController.text = configuracion.nit!;
        nombreLaboratorioController.text = configuracion.nombreLaboratorio!;
        direccionLaboratorioController.text =
            configuracion.direccionLaboratorio!;
        telefonosLaboratorioController.text =
            configuracion.telefonosLaboratorio!;
        correoLaboratorioController.text = configuracion.correoLaboratorio!;
        webLaboratorioController.text = configuracion.webLaboratorio!;
        bacteriologoLaboratorioController.text =
            configuracion.bacteriologoLaboratorio!;
        tarjetaPLaboratorioController.text = configuracion.tarjetaPLaboratorio!;

        urlFirmaLaboratorioController.text =
            configuracion.urlFirmaLaboratorio!.substring(0, 180);
        urlLogoLaboratorioController.text =
            configuracion.urlLogoLaboratorio!.substring(0, 180);
        fimage.fileImgStr64 = configuracion.urlFirmaLaboratorio!;
        fimageLogo.fileImgStr64 = configuracion.urlLogoLaboratorio!;

        setState(
          () => cargando = !cargando,
        );
      });
    } catch (e) {
      showToastB(fToast, 'Error obteniedndo la información de internet',
          bacgroundColor: Colors.red,
          frontColor: Colors.yellow,
          gravity: ToastGravity.BOTTOM_RIGHT,
          icon: Icon(MdiIcons.alert));
      print('Error: $e');
    }
  }

  Future<Fimage> _getFirmaImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    print(pickedImage?.path);
    File xfile = File(pickedImage!.path);
    List<int> imageBytes = xfile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    Fimage fimage = Fimage(xfile, base64Image);
    return fimage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onInverseSurface,
        title: const Text('Configuración'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_applications,
                  color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                setState(() {
                  guardando = !guardando;
                });
                configuracion.urlFirmaLaboratorio = fimage.fileImgStr64;
                configuracion.urlLogoLaboratorio = fimageLogo.fileImgStr64;
                guardarConfiguracion(context, configuracion).then(
                  (value) {
                    showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) => const ModalFit(
                        title: 'Configuración almacenada',
                        asset: 'images/logo.png',
                      ),
                    );
                    setState(() {
                      guardando = !guardando;
                    });
                  },
                );
              },
              icon: const Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Form(
            onChanged: () {
              if (!cargando) {
                configuracion.nit = nitLaboratorioController.text;
                configuracion.nombreLaboratorio =
                    nombreLaboratorioController.text;
                configuracion.direccionLaboratorio =
                    direccionLaboratorioController.text;
                configuracion.telefonosLaboratorio =
                    telefonosLaboratorioController.text;
                configuracion.correoLaboratorio =
                    correoLaboratorioController.text;
                configuracion.webLaboratorio = webLaboratorioController.text;
                configuracion.bacteriologoLaboratorio =
                    bacteriologoLaboratorioController.text;
                configuracion.tarjetaPLaboratorio =
                    tarjetaPLaboratorioController.text;
                configuracion.urlFirmaLaboratorio =
                    urlFirmaLaboratorioController.text;
                configuracion.urlLogoLaboratorio =
                    urlLogoLaboratorioController.text;
                configuracion.urlFirmaLaboratorio = fimage.fileImgStr64;
                configuracion.urlLogoLaboratorio = fimageLogo.fileImgStr64;
              }
            },
            child: Column(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Nit',
                      controller: nitLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Laboratorio',
                      controller: nombreLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Dirección Laboratorio',
                      controller: direccionLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Telefonos Laboratorio',
                      controller: telefonosLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Correo Electrónico Laboratorio',
                      controller: correoLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldI(
                      labelText: 'Sitio Web Laboratorio',
                      controller: webLaboratorioController,
                      colort: colort,
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 0.7 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldI(
                          labelText: 'Bacteriólogo',
                          controller: bacteriologoLaboratorioController,
                          colort: colort,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.3 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldI(
                          labelText: 'T.P.',
                          controller: tarjetaPLaboratorioController,
                          colort: colort,
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 0.95 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldI(
                          labelText: 'Firma Bacteriólogo Laboratorio (400x120)',
                          controller: urlFirmaLaboratorioController,
                          colort: colort,
                          minLines: 4,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    fimage.fileImgStr64 != ''
                        ? Image(image: fimage.imageProvider!)
                        : const SizedBox(),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () async {
                          fimage = await _getFirmaImageFromGallery();
                          imageFirma = fimage.fileImgStr64;
                          urlFirmaLaboratorioController.text =
                              imageFirma.substring(0, 180);
                          print(fimage.fileImg.path);
                          setState(() {});
                        },
                        child: const Text('Cargar firma'),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 0.95 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFieldI(
                          labelText: 'Logo Laboratorio (500x500)',
                          controller: urlLogoLaboratorioController,
                          colort: colort,
                          minLines: 4,
                        ),
                      ),
                    ),
                    fimageLogo.fileImgStr64 != ''
                        ? Image(image: fimageLogo.imageProvider!)
                        : const SizedBox(),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ElevatedButton(
                        onPressed: () async {
                          fimageLogo = await _getFirmaImageFromGallery();
                          imageLogo = fimageLogo.fileImgStr64;
                          urlLogoLaboratorioController.text =
                              imageLogo.substring(0, 180);
                          print(fimageLogo.fileImg.path);
                          setState(() {});
                        },
                        child: const Text('Cargar Logo'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        cargando
            ? const Center(child: CircularProgressIndicator())
            : const SizedBox()
      ]),
    );
  }
}
