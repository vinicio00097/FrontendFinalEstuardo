import 'dart:convert';

import 'package:clinica_frontend/Dao/IRecetaDao.dart';
import 'package:clinica_frontend/Models/Receta.dart';
import 'package:http/http.dart' as http;

class RecetaService implements IRecetaDao{
  String _baseURL="https://bitdatasolution.com/clinica/";
  String _baseURL2="http://localhost:8081/";

  @override
  Future add(Receta obj) async {
    try{
      var response=await http.post(
        "${_baseURL}Recetas/Create",
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
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future update(Receta obj) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}