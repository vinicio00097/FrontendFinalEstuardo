import 'dart:convert';

import 'package:clinica_frontend/Dao/IPersonalDao.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:clinica_frontend/Services/PersonalService.dart';

class PersonalVM{
  IPersonalDao _personalDao=new PersonalService();

  Future<dynamic> getAll() async {
    List response=await _personalDao.getAll();

    switch (response[0]) {
      case 0:
        return [0];
        break;
      case 1:
        List<Personal> personal=[];

        for(var item in jsonDecode(response[1])["data"]){
          personal.add(Personal.fromJson(item));
        }

        return [1,personal];
        break;
      case 2:
        return[2];
        break;
    }
  }
}