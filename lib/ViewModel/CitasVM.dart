import 'dart:convert';

import 'package:clinica_frontend/Dao/ICitaDao.dart';
import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Services/CitaService.dart';

class CitasVM{
  ICitaDao _citaDao=new CitaService();

  Future<dynamic> add(CitaPaciente obj) async {
    List response=await _citaDao.add(obj);

    switch (response[0]) {
      case 0:
        return [0];
        break;
      case 1:
        return [1,CitaPaciente.fromJson(jsonDecode(response[1])["data"])];
        break;
      case 2:
        return [2];
        break;
    }
  }

  Future<dynamic> delete(int id)async{
    List response=await _citaDao.delete(id);

    switch (response[0]) {
      case 0:
        return [0];
        break;
      case 1:
        return [1];
        break;
      case 2:
        return [2];
        break;
    }
  }

  Future<dynamic> update(CitaPaciente obj) async{
    List response=await _citaDao.update(obj);

    switch (response[0]) {
      case 0:
        return [0];
        break;
      case 1:
        return [1,CitaPaciente.fromJson(jsonDecode(response[1])["data"])];
        break;
      case 2:
        break;
    }
  }
}