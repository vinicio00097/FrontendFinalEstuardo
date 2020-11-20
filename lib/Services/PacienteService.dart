import 'dart:convert';

import 'package:clinica_frontend/Dao/IPacienteDao.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:http/http.dart' as http;

class PacienteServices implements IPacienteDao{
  String _baseURL="https://bitdatasolution.com/clinica/";
  String _baseURL2="http://localhost:8081/";
  @override
  Future add(Paciente obj) async {
    try{
      var response=await http.post(
          "${_baseURL}Pacientes/Create",
          headers: {"Content-Type": "application/json"},
        body: jsonEncode(obj)
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      print(e);
      return [2];
    }
  }

  @override
  Future delete(int id) async {
    try{
      var response=await http.delete(
          "${_baseURL}Pacientes/Delete/$id",
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }

  @override
  Future getAll() async {
    try{
      var response=await http.get(
          "${_baseURL}Pacientes"
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }

  @override
  Future update(Paciente obj) async {
    try{
      var response=await http.put(
          "${_baseURL}Pacientes/Update",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(obj)
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      print(e);
      return [2];
    }
  }

  @override
  Future updateInternado(Paciente obj) async {
    try{
      var response=await http.put(
          "${_baseURL}Pacientes/Internados/Update",
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(obj)
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      print(e);
      return [2];
    }
  }

}