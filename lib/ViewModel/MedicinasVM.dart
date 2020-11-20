import 'dart:convert';

import 'package:clinica_frontend/Dao/IMedicinaDao.dart';
import 'package:clinica_frontend/Models/Medicina.dart';
import 'package:clinica_frontend/Services/MedicinaService.dart';

class MedicinasVM{
  IMedicinaDao _medicinaDao=new MedicinaService();

  Future<dynamic> getAll() async {
    List response=await _medicinaDao.getAll();

    switch (response.elementAt(0)) {
      case 0:
        return [0];
        break;
      case 1:
        List<Medicina> medicinas=[];
        for(var item in jsonDecode(response.elementAt(1))["data"]){
          medicinas.add(Medicina.fromJson(item));
        }

        return [1,medicinas];
        break;
      case 2:
        return [2];
        break;
    }
  }
}