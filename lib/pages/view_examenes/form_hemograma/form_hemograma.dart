// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:movavid/models/hg_rayto.dart';
import 'package:movavid/providers/hrayto_provider.dart';
import 'package:provider/provider.dart';

class FormHemograma extends StatefulWidget {
  final String identificacion;
  final String fecha;
  final String observaciones;
  final List<Map<String, dynamic>> hemograma;

  const FormHemograma(
      {super.key,
      required this.hemograma,
      required this.identificacion,
      required this.fecha,
      required this.observaciones});

  @override
  State<FormHemograma> createState() => _FormHemogramaState();
}

class _FormHemogramaState extends State<FormHemograma> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Widget> formFields = [];
  String fsistematizado = '';
  HRayto hrayto = HRayto();
  TextEditingController wbcController = TextEditingController();
  TextEditingController lymNumberController = TextEditingController();
  TextEditingController midNumberController = TextEditingController();
  TextEditingController graNumberController = TextEditingController();
  TextEditingController lymPercentController = TextEditingController();
  TextEditingController midPercentController = TextEditingController();
  TextEditingController graPercentController = TextEditingController();
  TextEditingController rbcController = TextEditingController();
  TextEditingController hgbController = TextEditingController();
  TextEditingController mchcController = TextEditingController();
  TextEditingController mchController = TextEditingController();
  TextEditingController mcvController = TextEditingController();
  TextEditingController rdwCvController = TextEditingController();
  TextEditingController rdwSdController = TextEditingController();
  TextEditingController hctController = TextEditingController();
  TextEditingController pltController = TextEditingController();
  TextEditingController mpvController = TextEditingController();
  TextEditingController pdwController = TextEditingController();
  TextEditingController pctController = TextEditingController();
  TextEditingController pLcrController = TextEditingController();
  TextEditingController observacionesController = TextEditingController();

  HRayto getHemograma() {
    return hrayto;
  }

  late HRaytoProvider hraytoProvider;

  @override
  void initState() {
    super.initState();
    hraytoProvider = Provider.of<HRaytoProvider>(context, listen: false);
    if (widget.hemograma.isNotEmpty) {
      wbcController.text = widget.hemograma[0]['WBC'].toString();
      hraytoProvider.hrayto.wBC = wbcController.text;
      lymNumberController.text = widget.hemograma[1]['LYM#'].toString();
      hraytoProvider.hrayto.lYMn = lymNumberController.text;
      midNumberController.text = widget.hemograma[2]['MID#'].toString();
      hraytoProvider.hrayto.mIDn = midNumberController.text;
      graNumberController.text = widget.hemograma[3]['GRA#'].toString();
      hraytoProvider.hrayto.gRAn = graNumberController.text;
      lymPercentController.text = widget.hemograma[4]['LYM%'].toString();
      hraytoProvider.hrayto.lYMp = lymPercentController.text;
      midPercentController.text = widget.hemograma[5]['MID%'].toString();
      hraytoProvider.hrayto.mIDp = midPercentController.text;
      graPercentController.text = widget.hemograma[6]['GRA%'].toString();
      hraytoProvider.hrayto.gRAp = graPercentController.text;
      rbcController.text = widget.hemograma[7]['RBC'].toString();
      hraytoProvider.hrayto.rBC = rbcController.text;
      hgbController.text = widget.hemograma[8]['HGB'].toString();
      hraytoProvider.hrayto.hGB = hgbController.text;
      mchcController.text = widget.hemograma[9]['MCHC'].toString();
      hraytoProvider.hrayto.mCHC = mchcController.text;
      mchController.text = widget.hemograma[10]['MCH'].toString();
      hraytoProvider.hrayto.mCH = mchController.text;
      mcvController.text = widget.hemograma[11]['MCV'].toString();
      hraytoProvider.hrayto.mCV = mcvController.text;
      rdwCvController.text = widget.hemograma[12]['RDW-CV'].toString();
      hraytoProvider.hrayto.rDWCV = rdwCvController.text;
      rdwSdController.text = widget.hemograma[13]['RDW-SD'].toString();
      hraytoProvider.hrayto.rDWSD = rdwSdController.text;
      hctController.text = widget.hemograma[14]['HCT'].toString();
      hraytoProvider.hrayto.hCT = hctController.text;
      pltController.text = widget.hemograma[15]['PLT'].toString();
      hraytoProvider.hrayto.pLT = pltController.text;
      mpvController.text = widget.hemograma[16]['MPV'].toString();
      hraytoProvider.hrayto.mPV = mpvController.text;
      pdwController.text = widget.hemograma[17]['PDW'].toString();
      hraytoProvider.hrayto.pDW = pdwController.text;
      pctController.text = widget.hemograma[18]['PCT'].toString();
      hraytoProvider.hrayto.pCT = pctController.text;
      pLcrController.text = widget.hemograma[19]['P-LCR'].toString();
      observacionesController.text = widget.observaciones;
      hraytoProvider.hrayto.pLCR = pLcrController.text;
      hraytoProvider.hrayto.identificacion = widget.identificacion;
      hraytoProvider.hrayto.fecha = widget.fecha;
      setState(() {});
    }
    formFields = [
      _buildTextField(
        'WBC',
        wbcController,
      ),
      _buildTextField(
        'LYM#',
        lymNumberController,
      ),
      _buildTextField(
        'MID#',
        midNumberController,
      ),
      _buildTextField(
        'GRA#',
        graNumberController,
      ),
      _buildTextField(
        'LYM%',
        lymPercentController,
      ),
      _buildTextField(
        'MID%',
        midPercentController,
      ),
      _buildTextField(
        'GRA%',
        graPercentController,
      ),
      _buildTextField(
        'RBC',
        rbcController,
      ),
      _buildTextField(
        'HGB',
        hgbController,
      ),
      _buildTextField(
        'MCHC',
        mchcController,
      ),
      _buildTextField(
        'MCH',
        mchController,
      ),
      _buildTextField(
        'MCV',
        mcvController,
      ),
      _buildTextField(
        'RDW-CV',
        rdwCvController,
      ),
      _buildTextField(
        'RDW-SD',
        rdwSdController,
      ),
      _buildTextField(
        'HCT',
        hctController,
      ),
      _buildTextField(
        'PLT',
        pltController,
      ),
      _buildTextField(
        'MPV',
        mpvController,
      ),
      _buildTextField(
        'PDW',
        pdwController,
      ),
      _buildTextField(
        'PCT',
        pctController,
      ),
      _buildTextField(
        'P-LCR',
        pLcrController,
      ),
      _buildTextField(
        'Observaciones',
        observacionesController,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Formulario(
        identificacion: widget.identificacion,
        fecha: widget.fecha,
        hrayto: hrayto,
        wbcController: wbcController,
        lymNumberController: lymNumberController,
        midNumberController: midNumberController,
        graNumberController: graNumberController,
        lymPercentController: lymPercentController,
        midPercentController: midPercentController,
        graPercentController: graPercentController,
        rbcController: rbcController,
        hgbController: hgbController,
        mchcController: mchcController,
        mchController: mchController,
        mcvController: mcvController,
        rdwCvController: rdwCvController,
        rdwSdController: rdwSdController,
        hctController: hctController,
        pltController: pltController,
        mpvController: mpvController,
        pdwController: pdwController,
        pctController: pctController,
        pLcrController: pLcrController,
        hraytoProvider: hraytoProvider,
        observacionesController: observacionesController,
        formKey: _formKey,
        formFields: formFields);
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return TextFormField(
      maxLines: labelText.contains('obser') ? 3 : 1,
      validator: (value) {
        if (value == '') return 'Falta el valor de este campo';
        return null;
      },
      onChanged: (value) {
        setState(() {});
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}

class Formulario extends StatelessWidget {
  final String identificacion;
  final String fecha;
  const Formulario({
    super.key,
    required this.hrayto,
    required this.wbcController,
    required this.lymNumberController,
    required this.midNumberController,
    required this.graNumberController,
    required this.lymPercentController,
    required this.midPercentController,
    required this.graPercentController,
    required this.rbcController,
    required this.hgbController,
    required this.mchcController,
    required this.mchController,
    required this.mcvController,
    required this.rdwCvController,
    required this.rdwSdController,
    required this.hctController,
    required this.pltController,
    required this.mpvController,
    required this.pdwController,
    required this.pctController,
    required this.pLcrController,
    required this.hraytoProvider,
    required GlobalKey<FormState> formKey,
    required this.formFields,
    required this.identificacion,
    required this.fecha,
    required this.observacionesController,
  }) : _formKey = formKey;

  final HRayto hrayto;
  final TextEditingController wbcController;
  final TextEditingController lymNumberController;
  final TextEditingController midNumberController;
  final TextEditingController graNumberController;
  final TextEditingController lymPercentController;
  final TextEditingController midPercentController;
  final TextEditingController graPercentController;
  final TextEditingController rbcController;
  final TextEditingController hgbController;
  final TextEditingController mchcController;
  final TextEditingController mchController;
  final TextEditingController mcvController;
  final TextEditingController rdwCvController;
  final TextEditingController rdwSdController;
  final TextEditingController hctController;
  final TextEditingController pltController;
  final TextEditingController mpvController;
  final TextEditingController pdwController;
  final TextEditingController pctController;
  final TextEditingController pLcrController;
  final TextEditingController observacionesController;
  final HRaytoProvider hraytoProvider;
  final GlobalKey<FormState> _formKey;
  final List<Widget> formFields;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {
        print("forms");
        hrayto.wBC = wbcController.text;
        hrayto.lYMn = lymNumberController.text;
        hrayto.mIDn = midNumberController.text;
        hrayto.gRAn = graNumberController.text;
        hrayto.lYMp = lymPercentController.text;
        hrayto.mIDp = midPercentController.text;
        hrayto.gRAp = graPercentController.text;
        hrayto.rBC = rbcController.text;
        hrayto.hGB = hgbController.text;
        hrayto.mCHC = mchcController.text;
        hrayto.mCH = mchController.text;
        hrayto.mCV = mcvController.text;
        hrayto.rDWCV = rdwCvController.text;
        hrayto.rDWSD = rdwSdController.text;
        hrayto.hCT = hctController.text;
        hrayto.pLT = pltController.text;
        hrayto.mPV = mpvController.text;
        hrayto.pDW = pdwController.text;
        hrayto.pCT = pctController.text;
        hrayto.pLCR = pLcrController.text;
        hrayto.identificacion = identificacion;
        hrayto.observaciones = observacionesController.text;
        hrayto.fecha = fecha;
        hraytoProvider.setData(hrayto);
      },
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: formFields,
        ),
      ),
    );
  }
}
