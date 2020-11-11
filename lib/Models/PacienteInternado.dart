import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:flutter/material.dart';

class PacienteInternado{
  int idPacienteInternado;
  DateTime fechaIngreso;
  DateTime fechaSalida;
  Habitacion habitacion;

  PacienteInternado({this.idPacienteInternado, this.fechaIngreso,
      this.fechaSalida, this.habitacion});

  factory PacienteInternado.fromJson(dynamic json){

    return PacienteInternado(idPacienteInternado: json["idPacienteInternado"],
        fechaIngreso: json["fechaIngreso"]!=null?DateTime.parse(json["fechaIngreso"]):json["fechaIngreso"],
    fechaSalida: json["fechaSalida"]!=null?DateTime.parse(json["fechaSalida"]):json["fechaSalida"]
        ,habitacion: Habitacion.fromJson(json["habitacion"]));
  }

  Map<String,dynamic> toJson()=>{
    'idPacienteInternado':idPacienteInternado,
    'fechaIngreso':fechaIngreso!=null? fechaIngreso.toString().split(".")[0]:null,
    'fechaSalida':fechaSalida!=null? fechaSalida.toString().split(".")[0]:null,
    'habitacion':habitacion
  };
}