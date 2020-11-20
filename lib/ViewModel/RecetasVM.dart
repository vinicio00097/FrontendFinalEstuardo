import 'dart:convert';

import 'package:clinica_frontend/Dao/IRecetaDao.dart';
import 'package:clinica_frontend/Models/Receta.dart';
import 'package:clinica_frontend/Services/RecetaService.dart';

class RecetasVM{
  IRecetaDao recetaDao=new RecetaService();

  Future<dynamic> add(Receta obj) async {
    List response=await recetaDao.add(obj);

    switch (response.elementAt(0)) {
      case 0:
        return [0];
        break;
      case 1:
        return [1,Receta.fromJson(jsonDecode(response.elementAt(1))["data"])];
        break;
      case 2:
        return [2];
        break;
    }
  }
}