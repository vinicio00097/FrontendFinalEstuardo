import 'dart:convert';
import 'dart:html';

import 'package:clinica_frontend/Dao/ICitaDao.dart';
import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:http/http.dart' as http;

class CitaService implements ICitaDao{
  String _baseURL="https://bitdatasolution.com/clinica/";
  @override
  Future add(CitaPaciente obj) async {
    try{
      var response=await http.post(
          "${_baseURL}Pacientes/Citas/Create",
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
          "${_baseURL}Pacientes/Citas/Delete/${id}"
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
  Future getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future update(CitaPaciente obj) async {
    try{
      var response=await http.put(
          "${_baseURL}Pacientes/Citas/Edit",
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