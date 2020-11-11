import 'dart:convert';

import 'package:clinica_frontend/Dao/ITipoHabitacionDao.dart';
import 'package:clinica_frontend/Models/TipoHabitacion.dart';
import 'package:clinica_frontend/Services/TiposHabitacionService.dart';

class TiposHabitacionVM{
  ITipoHabitacionDao _iTipoHabitacionDao=TiposHabitacion();

  Future<dynamic> getAll() async {
    try{
      List response=await _iTipoHabitacionDao.getAll();

      if(response[0]==1){
        List<TipoHabitacion> tiposHabitacion=[];

        for(var item in jsonDecode(response.elementAt(1))["data"]){
          tiposHabitacion.add(TipoHabitacion.fromJson(item));
        }

        return [1,tiposHabitacion];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }
}