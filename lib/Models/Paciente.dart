import 'dart:convert';

import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/PacienteInternado.dart';

class Paciente{
  int idPaciente;
  String primerNombre;
  String segundoNombre;
  String primerApellido;
  String segundoApellido;
  String tercerApellido;
  String apellidoCasada;
  String nit;
  String dpi;
  List<PacienteInternado> internados;
  List<CitaPaciente> citas;

  Paciente({
    this.idPaciente,
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.tercerApellido,
    this.apellidoCasada,
    this.nit,
    this.dpi,
    this.internados,
    this.citas
});

  factory Paciente.fromJson(dynamic json){
    List<PacienteInternado> internados=[];
    List<CitaPaciente> citas=[];

    for(var item in json["internados"]){
      internados.add(PacienteInternado.fromJson(item));
    }

    for(var item in json["citas"]){
      citas.add(CitaPaciente.fromJson(item));
    }

    return Paciente(
      idPaciente: json["idPaciente"],
        primerNombre: json["primeroNombre"],
      segundoNombre: json["segundoNombre"],
      primerApellido: json["primerApellido"],
      segundoApellido: json["segundoApellido"],
      tercerApellido: json["tercerApellido"],
      apellidoCasada: json["apellidoCasada"],
      nit: json["nit"],
      dpi: json["dpi"],
      internados: internados,
      citas: citas
    );
  }

  Map<String,dynamic> toJson()=>{
    'idPaciente':idPaciente,
    'primeroNombre':primerNombre,
    'segundoNombre':segundoNombre,
    'primerApellido':primerApellido,
    'segundoApellido':segundoApellido,
    'tercerApellido':tercerApellido,
    'apellidoCasada':apellidoCasada,
    'nit':nit,
    'dpi':dpi,
    'internados':internados!=null?internados.map((e) => e.toJson()).toList():[],
    'citas':citas!=null?citas.map((e) => e.toJson()).toList():[]
  };
}