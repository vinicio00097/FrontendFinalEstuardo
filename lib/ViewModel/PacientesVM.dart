import 'dart:convert';

import 'package:clinica_frontend/Dao/IPacienteDao.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Services/PacienteService.dart';
import 'package:flutter/cupertino.dart';

class PacientesVM{
  IPacienteDao _pacienteDao=new PacienteServices();

  Future<dynamic> getAll() async {
    List response=await _pacienteDao.getAll();

    switch(response[0]){
      case 0:
        return [0];
        break;
      case 1:
        List<Paciente> pacientes=[];

        for(var item in jsonDecode(response[1])["data"]){
          pacientes.add(Paciente.fromJson(item));

        }

        return [1,pacientes];
        break;
      case 2:
        return [2];
        break;
    }
  }

  Future<dynamic> add(Paciente obj) async {
    List response=await _pacienteDao.add(obj);

    switch(response[0]){
      case 0:
        return [0];
        break;
      case 1:
        return [1,Paciente.fromJson(jsonDecode(response[1])["data"])];
        break;
      case 2:
        return [2];
        break;
    }
  }

  Future<dynamic> update(Paciente obj) async {
    List response=await _pacienteDao.update(obj);

    switch (response[0]) {
      case 0:
        return [0];
        break;
      case 1:
        return [1,Paciente.fromJson(jsonDecode(response[1])["data"])];
        break;
      case 2:
        return [2];
        break;
    }
  }

  Future<dynamic> updateInternado(Paciente obj)async{
    List response=await _pacienteDao.updateInternado(obj);

    switch (response[0]) {
      case 0:
        return [0];
        break;
      case 1:
        return [1,Paciente.fromJson(jsonDecode(response[1])["data"])];
        break;
      case 2:
        return [2];
        break;
    }
  }

  Future<dynamic> delete(int id)async{
    List response=await _pacienteDao.delete(id);

    switch (response[0]) {
      case 0:
        return[0];
        break;
      case 1:
        return [1];
        break;
      case 2:
        return [2];
        break;
    }
  }
}