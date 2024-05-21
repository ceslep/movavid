// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movavid/api/api_laboratorio.dart';
import 'package:movavid/functions/show_toast.dart';
import 'package:movavid/models/coprologico.dart';
import 'package:movavid/models/data-hemat.dart';
import 'package:movavid/models/examen_tipo1_model.dart';
import 'package:movavid/models/examen_tipo2_model.dart';
import 'package:movavid/models/frotis_vaginal_model.dart';
import 'package:movavid/models/hemograma_rayto.dart';
import 'package:movavid/models/hg_rayto.dart';
import 'package:movavid/models/paciente.dart';
import 'package:movavid/models/parcial_orina.dart';
import 'package:movavid/models/perfil_lipidico_model.dart';
import 'package:movavid/models/uni_constd.dart';
import 'package:movavid/pages/view_examenes/coprologico/coprologico.dart';
import 'package:movavid/pages/view_examenes/examenTipo1/view_examen_tipo1.dart';
import 'package:movavid/pages/view_examenes/examenTipo2/view_examen_tipo2.dart';
import 'package:movavid/pages/view_examenes/form_hemograma/hemograma_rayto.dart';
import 'package:movavid/pages/view_examenes/form_hemograma/hemograma_rayto_new.dart';
import 'package:movavid/pages/view_examenes/frotisVaginal/frotis_vaginal.dart';
import 'package:movavid/pages/view_examenes/parcialOrina/parcial_orina.dart';
import 'package:movavid/pages/view_examenes/perfilLipidico/perfil_lipidico.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Future<void> hemogramas(BuildContext context, Paciente paciente, String fecha,
    String codexamen, FToast fToast) async {
  getHemogramaRayto(context,
          identificacion: paciente.identificacion!, fecha: fecha)
      .then((HemogramaRayto value) async {
    HemogramaRayto hemograma = value;
    if (hemograma.identificacion != '' && hemograma.identificacion != 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewHemogramaRayto(
            hemograma: hemograma,
            fecha: fecha,
            paciente: paciente,
            codexamen: codexamen,
          ),
        ),
      );
      return true;
    } else if (hemograma.identificacion == 'Error') {
      getHemogramaRaytoNew(context,
              identificacion: paciente.identificacion!, fecha: fecha)
          .then(
        (HRayto value) async {
          HRayto hemograma = value;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewHemogramaRaytoNew(
                paciente: paciente,
                hemograma: hemograma,
                fecha: fecha,
                codexamen: codexamen,
              ),
            ),
          );
        },
      );
      return true;
    } else {
      showToastB(
        fToast,
        'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
        bacgroundColor: Colors.red,
        frontColor: Colors.yellow,
        icon: Icon(
          MdiIcons.networkOff,
          color: Colors.yellow,
        ),
        milliseconds: 10,
      );
    }
  });
}

Future<bool> hemogramas2(BuildContext context, Paciente paciente, String fecha,
    String codexamen, FToast fToast) async {
  HemogramaRayto hemograma = await getHemogramaRayto(context,
      identificacion: paciente.identificacion!, fecha: fecha);

  if (hemograma.identificacion != '' && hemograma.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewHemogramaRayto(
          hemograma: hemograma,
          fecha: fecha,
          paciente: paciente,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (hemograma.identificacion == 'Error') {
    HRayto hemograma = await getHemogramaRaytoNew(context,
        identificacion: paciente.identificacion!, fecha: fecha);
    print({"e": hemograma.toJson()});
    if (hemograma.identificacion == 'Error') {
      DataHemat dataHemat = await getDataHemat(
        context,
        paciente.identificacion!,
        fecha,
      );
      hemograma.identificacion = paciente.identificacion;
      hemograma.fecha = fecha;
      hemograma.wBC = dataHemat.wbc ?? '';
      hemograma.lYMn = dataHemat.lyMn ?? '';
      hemograma.mIDn = dataHemat.miDn ?? '';
      hemograma.gRAn = dataHemat.grAn ?? '';
      hemograma.lYMp = dataHemat.lyMp ?? '';
      hemograma.mIDp = dataHemat.miDp ?? '';
      hemograma.gRAp = dataHemat.grAp ?? '';
      hemograma.rBC = dataHemat.rbc ?? '';
      hemograma.hGB = dataHemat.hgb ?? '';
      hemograma.mCHC = dataHemat.mchc ?? '';
      hemograma.mCH = dataHemat.mch ?? '';
      hemograma.mCV = dataHemat.mcv ?? '';
      hemograma.rDWCV = dataHemat.rdwcv ?? '';
      hemograma.rDWSD = dataHemat.rdwsd ?? '';
      hemograma.hCT = dataHemat.hct ?? '';
      hemograma.pLT = dataHemat.plt ?? '';
      hemograma.mPV = dataHemat.mpv ?? '';
      hemograma.pDW = dataHemat.pdw ?? '';
      hemograma.pCT = dataHemat.pct ?? '';
      hemograma.pLCR = dataHemat.plcr ?? '';
      hemograma.observaciones = '';
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewHemogramaRaytoNew(
          paciente: paciente,
          hemograma: hemograma,
          fecha: fecha,
          codexamen: codexamen,
        ),
      ),
    );

    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}

Future<void> parcialOrina(BuildContext context, Paciente paciente, String fecha,
    String codexamen, FToast fToast) async {
  getParcialOrina(context,
          identificacion: paciente.identificacion!, fecha: fecha)
      .then((ParcialOrina value) async {
    ParcialOrina parcialOrina = value;
    if (parcialOrina.identificacion != '' &&
        parcialOrina.identificacion != 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewParcialOrina(
            parcialOrina: parcialOrina,
            fecha: fecha,
            paciente: paciente,
            codexamen: codexamen,
          ),
        ),
      );
    } else if (parcialOrina.identificacion == 'Error') {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewParcialOrina(
            paciente: paciente,
            parcialOrina: ParcialOrina(),
            fecha: fecha,
            codexamen: codexamen,
          ),
        ),
      );
    } else {
      showToastB(
        fToast,
        'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
        bacgroundColor: Colors.red,
        frontColor: Colors.yellow,
        icon: Icon(
          MdiIcons.networkOff,
          color: Colors.yellow,
        ),
        milliseconds: 10,
      );
    }
  });
}

Future<bool> parcialOrina2(BuildContext context, Paciente paciente,
    String fecha, String codexamen, FToast fToast) async {
  ParcialOrina parcialOrina = await getParcialOrina(context,
      identificacion: paciente.identificacion!, fecha: fecha);

  if (parcialOrina.identificacion != '' &&
      parcialOrina.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewParcialOrina(
          parcialOrina: parcialOrina,
          fecha: fecha,
          paciente: paciente,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (parcialOrina.identificacion == 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewParcialOrina(
          paciente: paciente,
          parcialOrina: ParcialOrina(),
          fecha: fecha,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}

Future<bool> coprologico2(BuildContext context, Paciente paciente, String fecha,
    String codexamen, FToast fToast) async {
  Coprologico coprologico = await getCoprologico(context,
      identificacion: paciente.identificacion!, fecha: fecha);

  if (coprologico.identificacion != '' &&
      coprologico.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewCoprologico(
          coprologico: coprologico,
          fecha: fecha,
          paciente: paciente,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (coprologico.identificacion == 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewCoprologico(
          paciente: paciente,
          coprologico: Coprologico(),
          fecha: fecha,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}

Future<bool> examentipo_1(BuildContext context, Paciente paciente, String fecha,
    String codexamen, String nombreExamen, FToast fToast) async {
  ExamenTipo1 examen = await getTipo1(context,
      identificacion: paciente.identificacion!,
      fecha: fecha,
      codexamen: codexamen);

  if (examen.identificacion != '' && examen.identificacion != 'Error') {
    UniConst uniConst = await getUniConst(context, codexamen);
    examen.unidades = uniConst.unidades;
    examen.constant = uniConst.constante;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewExamenTipo1(
          examen: examen,
          fecha: fecha,
          paciente: paciente,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (examen.identificacion == 'Error') {
    UniConst uniConst = await getUniConst(context, codexamen);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewExamenTipo1(
          paciente: paciente,
          examen: ExamenTipo1(
              examen: codexamen,
              nombreExamen: nombreExamen,
              identificacion: paciente.identificacion,
              fecha: fecha,
              observaciones: '',
              valoracion: '',
              unidades: uniConst.unidades,
              constant: uniConst.constante),
          fecha: fecha,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}

Future<bool> examentipo_2(BuildContext context, Paciente paciente, String fecha,
    String codexamen, String nombreExamen, FToast fToast) async {
  ExamenTipo2 examen = await getTipo2(context,
      identificacion: paciente.identificacion!,
      fecha: fecha,
      codexamen: codexamen);

  if (examen.identificacion != '' && examen.identificacion != 'Error') {
    UniConst uniConst = await getUniConst(context, codexamen);
    examen.unidades = uniConst.unidades;
    examen.constant = uniConst.constante;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewExamenTipo2(
          examen: examen,
          fecha: fecha,
          paciente: paciente,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (examen.identificacion == 'Error') {
    UniConst uniConst = await getUniConst(context, codexamen);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewExamenTipo2(
          paciente: paciente,
          examen: ExamenTipo2(
              examen: codexamen,
              identificacion: paciente.identificacion,
              observaciones: '',
              fecha: fecha,
              nombreExamen: nombreExamen,
              valoracion: '',
              unidades: uniConst.unidades,
              constant: uniConst.constante),
          fecha: fecha,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}

Future<bool> frotisVaginal(BuildContext context, Paciente paciente,
    String fecha, String codexamen, FToast fToast) async {
  FrotisVaginal examen = await getFrotisVaginal(
    context,
    identificacion: paciente.identificacion!,
    fecha: fecha,
  );

  if (examen.identificacion != '' && examen.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewFrotisVaginal(
          fecha: fecha,
          paciente: paciente,
          frotisVaginal: examen,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (examen.identificacion == 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewFrotisVaginal(
          paciente: paciente,
          fecha: fecha,
          frotisVaginal: FrotisVaginal(
            identificacion: paciente.identificacion,
            observaciones: '',
            fecha: fecha,
          ),
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}

Future<bool> perfilLipidico(BuildContext context, Paciente paciente,
    String fecha, String codexamen, FToast fToast) async {
  PerfilLipidico examen = await getPerfilLipidico(
    context,
    identificacion: paciente.identificacion!,
    fecha: fecha,
  );

  if (examen.identificacion != '' && examen.identificacion != 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPerfilLipidico(
          fecha: fecha,
          paciente: paciente,
          perfilLipidico: examen,
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else if (examen.identificacion == 'Error') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewPerfilLipidico(
          paciente: paciente,
          fecha: fecha,
          perfilLipidico: PerfilLipidico(
            identificacion: paciente.identificacion,
            observaciones: '',
            fecha: fecha,
          ),
          codexamen: codexamen,
        ),
      ),
    );
    return true;
  } else {
    showToastB(
      fToast,
      'Sin Internet. Ha ocurrido un error obteniendo los datos del servidor',
      bacgroundColor: Colors.red,
      frontColor: Colors.yellow,
      icon: Icon(
        MdiIcons.networkOff,
        color: Colors.yellow,
      ),
      milliseconds: 10,
    );
  }
  return false;
}
