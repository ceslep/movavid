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
import 'package:movavid/providers/url_provider.dart';
import 'package:movavid/widgets/app_page.dart';
import 'package:movavid/widgets/loading_overlay.dart';
import 'package:movavid/widgets/modals/floating_modal.dart';
import 'package:movavid/widgets/modals/modal_fit.dart';
import 'package:movavid/widgets/section_card.dart';
import 'package:movavid/widgets/text_field.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

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
            base64Decode(fileImgStr64);
        return MemoryImage(bytes);
      } catch (error) {
        print('Error decoding image: $error');
        return null;
      }
    } else {
      return null;
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
  bool probando = false;
  bool? conexionOk;
  FToast fToast = FToast();
  Color colort = Colors.amber;
  ConfiguracionModel configuracion = ConfiguracionModel();
  late final TextEditingController urlServidorController = TextEditingController();
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

  String _cortar(String? valor) {
    if (valor == null || valor.isEmpty) return '';
    return valor.length > 180 ? valor.substring(0, 180) : valor;
  }

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    urlServidorController.text =
        Provider.of<UrlProvider>(context, listen: false).url;
    setState(() => cargando = true);
    try {
      getConfiguracion(context).then((value) {
        if (!mounted) return;
        configuracion = value;
        nitLaboratorioController.text = configuracion.nit ?? '';
        nombreLaboratorioController.text =
            configuracion.nombreLaboratorio ?? '';
        direccionLaboratorioController.text =
            configuracion.direccionLaboratorio ?? '';
        telefonosLaboratorioController.text =
            configuracion.telefonosLaboratorio ?? '';
        correoLaboratorioController.text =
            configuracion.correoLaboratorio ?? '';
        webLaboratorioController.text = configuracion.webLaboratorio ?? '';
        bacteriologoLaboratorioController.text =
            configuracion.bacteriologoLaboratorio ?? '';
        tarjetaPLaboratorioController.text =
            configuracion.tarjetaPLaboratorio ?? '';
        urlFirmaLaboratorioController.text =
            _cortar(configuracion.urlFirmaLaboratorio);
        urlLogoLaboratorioController.text =
            _cortar(configuracion.urlLogoLaboratorio);
        fimage.fileImgStr64 = configuracion.urlFirmaLaboratorio ?? '';
        fimageLogo.fileImgStr64 = configuracion.urlLogoLaboratorio ?? '';

        setState(() => cargando = false);
      });
    } catch (e) {
      showToastB(fToast, 'Error obteniedndo la información de internet',
          bacgroundColor: Colors.red,
          frontColor: Colors.yellow,
          gravity: ToastGravity.BOTTOM_RIGHT,
          icon: Icon(MdiIcons.alert));
      print('Error: $e');
      if (mounted) setState(() => cargando = false);
    }
  }

  Future<Fimage> _getFirmaImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return Fimage(File(''), '');
    print(pickedImage.path);
    File xfile = File(pickedImage.path);
    List<int> imageBytes = xfile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    Fimage fimage = Fimage(xfile, base64Image);
    return fimage;
  }

  Future<void> _probarConexion() async {
    setState(() {
      probando = true;
      conexionOk = null;
    });
    final UrlProvider urlProvider =
        Provider.of<UrlProvider>(context, listen: false);
    final String urlAnterior = urlProvider.url;
    urlProvider.setUrl(urlServidorController.text);
    final bool ok = await probarServidor(context);
    if (!ok) {
      urlProvider.setUrl(urlAnterior);
    }
    if (!mounted) return;
    setState(() {
      probando = false;
      conexionOk = ok;
    });
  }

  void _guardar() {
    setState(() {
      guardando = true;
    });
    configuracion.urlFirmaLaboratorio = fimage.fileImgStr64;
    configuracion.urlLogoLaboratorio = fimageLogo.fileImgStr64;
    guardarConfiguracion(context, configuracion).then(
      (value) {
        if (!mounted) return;
        setState(() {
          guardando = false;
        });
        showFloatingModalBottomSheet(
          context: context,
          builder: (context) => const ModalFit(
            title: 'Configuración almacenada',
            asset: 'images/logo.png',
          ),
        );
      },
    );
  }

  Widget _campo(String label, TextEditingController controller,
      {int minLines = 1, int maxLines = 1}) {
    return TextFieldI(
      labelText: label,
      controller: controller,
      colort: colort,
      minLines: minLines,
      maxLines: maxLines,
    );
  }

  Widget _cargarImagen({
    required String title,
    required Fimage imagen,
    required TextEditingController controller,
    required VoidCallback onCargar,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _campo(title, controller)),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: onCargar,
              icon: const Icon(Icons.image_rounded, size: 18),
              label: const Text('Cargar'),
            ),
          ],
        ),
        if (imagen.fileImgStr64 != '' && imagen.imageProvider != null) ...[
          const SizedBox(height: 10),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: imagen.imageProvider!,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return AppPage(
      title: 'Configuración',
      actions: [
        IconButton(
          onPressed: guardando ? null : _guardar,
          tooltip: 'Guardar configuración',
          icon: guardando
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.save_rounded, color: scheme.primary),
        ),
      ],
      body: LoadingOverlay(
        visible: guardando,
        message: 'Guardando configuración...',
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
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
                        fimage.fileImgStr64;
                    configuracion.urlLogoLaboratorio =
                        fimageLogo.fileImgStr64;
                  }
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool wide = constraints.maxWidth >= 900;
                    final Widget serverCard = _cardServidor(scheme);
                    final Widget datosCard = SectionCard(
                      title: 'Datos del laboratorio',
                      icon: Icons.apartment_rounded,
                      child: Column(
                        children: [
                          _campo('Nit', nitLaboratorioController),
                          const SizedBox(height: 12),
                          _campo('Laboratorio', nombreLaboratorioController),
                          const SizedBox(height: 12),
                          _campo('Dirección Laboratorio',
                              direccionLaboratorioController),
                          const SizedBox(height: 12),
                          _campo('Teléfonos Laboratorio',
                              telefonosLaboratorioController),
                          const SizedBox(height: 12),
                          _campo('Correo Electrónico Laboratorio',
                              correoLaboratorioController),
                          const SizedBox(height: 12),
                          _campo('Sitio Web Laboratorio',
                              webLaboratorioController),
                        ],
                      ),
                    );
                    final Widget bacteriologoCard = SectionCard(
                      title: 'Bacteriólogo',
                      icon: Icons.science_rounded,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: _campo(
                                'Bacteriólogo', bacteriologoLaboratorioController),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: _campo(
                                'T.P.', tarjetaPLaboratorioController),
                          ),
                        ],
                      ),
                    );
                    final Widget imagenesCard = SectionCard(
                      title: 'Documentos e imágenes',
                      icon: Icons.image_rounded,
                      child: Column(
                        children: [
                          _cargarImagen(
                            title: 'Firma Bacteriólogo (400x120)',
                            imagen: fimage,
                            controller: urlFirmaLaboratorioController,
                            onCargar: () async {
                              fimage = await _getFirmaImageFromGallery();
                              imageFirma = fimage.fileImgStr64;
                              urlFirmaLaboratorioController.text =
                                  _cortar(imageFirma);
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 14),
                          _cargarImagen(
                            title: 'Logo Laboratorio (500x500)',
                            imagen: fimageLogo,
                            controller: urlLogoLaboratorioController,
                            onCargar: () async {
                              fimageLogo = await _getFirmaImageFromGallery();
                              imageLogo = fimageLogo.fileImgStr64;
                              urlLogoLaboratorioController.text =
                                  _cortar(imageLogo);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                    final Widget guardar = ElevatedButton.icon(
                      onPressed: guardando ? null : _guardar,
                      icon: guardando
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.save_rounded),
                      label: Text(guardando ? 'Guardando...' : 'Guardar'),
                    );

                    if (wide) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          serverCard,
                          const SizedBox(height: 14),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: datosCard,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    bacteriologoCard,
                                    const SizedBox(height: 14),
                                    imagenesCard,
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          guardar,
                          const SizedBox(height: 24),
                        ],
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        serverCard,
                        const SizedBox(height: 14),
                        datosCard,
                        const SizedBox(height: 14),
                        bacteriologoCard,
                        const SizedBox(height: 14),
                        imagenesCard,
                        const SizedBox(height: 16),
                        guardar,
                        const SizedBox(height: 24),
                      ],
                    );
                  },
                ),
              ),
            ),
            if (cargando)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  Widget _cardServidor(ColorScheme scheme) {
    final Color colorConexion = conexionOk == null
        ? scheme.onSurfaceVariant
        : conexionOk!
            ? Colors.green
            : scheme.error;
    return SectionCard(
      title: 'Servidor',
      icon: Icons.dns_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: urlServidorController,
            keyboardType: TextInputType.url,
            decoration: InputDecoration(
              labelText: 'URL del servidor',
              hintText: 'https://dominio.com/',
              prefixIcon: const Icon(Icons.link_rounded),
              suffixIcon: probando
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : Icon(Icons.cloud_rounded, color: colorConexion),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: probando ? null : _probarConexion,
                icon: const Icon(Icons.network_check_rounded, size: 18),
                label: Text(probando ? 'Probando...' : 'Probar conexión'),
              ),
              if (conexionOk != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: colorConexion.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        conexionOk!
                            ? Icons.check_circle_rounded
                            : Icons.error_rounded,
                        size: 14,
                        color: colorConexion,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        conexionOk! ? 'Conectado' : 'Sin conexión',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colorConexion,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}