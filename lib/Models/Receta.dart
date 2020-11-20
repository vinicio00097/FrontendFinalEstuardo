import 'dart:convert';

import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/DetallesReceta.dart';

class Receta{
  int idReceta;
  String fechaReceta;
  CitaPaciente citaPaciente;
  List<DetallesReceta> detallesRecetas;

  Receta(
  {this.idReceta, this.fechaReceta, this.citaPaciente, this.detallesRecetas});

  factory Receta.fromJson(dynamic json){
    List<DetallesReceta> detallesRecetas=[];
    for(var item in json["detallesRecetas"]){
      detallesRecetas.add(DetallesReceta.fromJson(item));
    }

    return Receta(
      idReceta: json["idReceta"],
      fechaReceta: json["fechaReceta"],
      //citaPaciente: json["citaPaciente"],
      detallesRecetas: detallesRecetas
    );
  }

  Map<String,dynamic> toJson()=>{
    "idReceta":idReceta,
    "citaPaciente":citaPaciente,
    "detallesRecetas":detallesRecetas.map((e) => e.toJson()).toList()
  };
}