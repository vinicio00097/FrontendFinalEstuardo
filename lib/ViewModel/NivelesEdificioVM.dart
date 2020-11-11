import 'dart:convert';

import 'package:clinica_frontend/Dao/INivelEdificioDao.dart';
import 'package:clinica_frontend/Models/NivelEdificio.dart';
import 'package:clinica_frontend/Services/NivelEdificioService.dart';

class NivelesEdificioVM{
  INivelEdificioDao _nivelEdificioDao=new NivelEdificioService();

  Future<dynamic> getAll() async {
    try{
      List response=await _nivelEdificioDao.getAll();

      if(response[0]==1){
        List<NivelEdificio> nivelesEdificio=[];

        for(var item in jsonDecode(response[1])["data"]){
          nivelesEdificio.add(NivelEdificio.fromJson(item));
        }

        return [1,nivelesEdificio];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }
}