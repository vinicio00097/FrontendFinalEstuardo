import 'dart:convert';

import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:clinica_frontend/Models/Receta.dart';

class CitaPaciente{
  int idCitaPaciente;
  DateTime fechaCita;
  Personal personal;
  Paciente paciente;
  List<Receta> recetas;

  CitaPaciente({this.idCitaPaciente, this.fechaCita, this.personal,this.paciente,this.recetas});

  factory CitaPaciente.fromJson(dynamic json){
    List<Receta> recetas=[];
    for(var item in json["recetas"]){
      recetas.add(Receta.fromJson(item));
    }

    return CitaPaciente(idCitaPaciente: json["idCitaPaciente"],
        fechaCita: json["fechaCita"]!=null?DateTime.parse(json["fechaCita"]):json["fechaCita"],
        personal: Personal.fromJson(json["personal"]),
      recetas: recetas
    );
  }

  Map<String,dynamic> toJson()=>{
    'idCitaPaciente':idCitaPaciente,
    'fechaCita':fechaCita!=null?fechaCita.toString().split(".")[0]:null,
    'personal':personal,
    'paciente':paciente
  };
}