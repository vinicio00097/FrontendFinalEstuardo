import 'dart:convert';
import 'dart:html';

import 'package:clinica_frontend/Dao/IHabitacionDao.dart';
import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:clinica_frontend/Services/HabitacionService.dart';

class HabitacionesVM{
  IHabitacion _habitacion=HabitacionService();

  Future<dynamic> getAllHabitaciones() async {
    try{
      List response= await _habitacion.getAll();

      if(response.elementAt(0)==1){
        List<Habitacion> habitaciones=[];

        for(var item in jsonDecode(response.elementAt(1))["data"]){
          habitaciones.add(Habitacion.fromJson(item));
        }

        return [1,habitaciones];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }

  Future<dynamic> update(Habitacion habitacion) async {
    try{
      List response=await _habitacion.update(habitacion);

      if(response[0]==1){
        return [1,Habitacion.fromJson(jsonDecode(response[1])["data"])];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }
}