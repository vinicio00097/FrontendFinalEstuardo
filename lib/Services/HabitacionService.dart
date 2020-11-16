import 'dart:convert';

import 'package:clinica_frontend/Dao/IHabitacionDao.dart';
import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:http/http.dart' as http;

class HabitacionService implements IHabitacion{
  String _baseURL="https://bitdatasolution.com/clinica/";

  @override
  Future add(Habitacion obj) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getAll() async {
    try{
      var response=await http.get(
          "${_baseURL}Habitaciones"
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
  Future update(Habitacion obj) async {
    try{
      var response=await http.put(
          "${_baseURL}Habitaciones/Edit",
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