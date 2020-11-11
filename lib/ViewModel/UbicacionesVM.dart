import 'dart:convert';

import 'package:clinica_frontend/Dao/IUbicacionDao.dart';
import 'package:clinica_frontend/Models/Ubicacion.dart';
import 'package:clinica_frontend/Services/UbicacionService.dart';

class UbicacionVM{
  IUbicacionDao _iUbicacionDao=UbicacionService();

  Future<dynamic> getAll() async {
    try{
      List response=await _iUbicacionDao.getAll();

      if(response[0]==1){
        List<Ubicacion> ubicaciones=[];

        for(var item in jsonDecode(response[1])["data"]){
          ubicaciones.add(Ubicacion.fromJson(item));
        }

        return [1,ubicaciones];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }
}