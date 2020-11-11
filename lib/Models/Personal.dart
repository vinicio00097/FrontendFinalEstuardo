import 'package:clinica_frontend/Models/DepartamentoEmpresa.dart';
import 'package:clinica_frontend/Models/PuestoEmpresa.dart';

class Personal{
  int idPersonalHospital;
  String numeroDeEmpleado;
  String primerNombre;
  String segundoNombre;
  String primerApellido;
  String segundoApellido;
  String apellidoDeCasada;
  String nit;
  String dpi;
  String telefono;
  String direccion;
  DepartamentoEmpresa departamentoEmpresa;
  PuestoEmpresa puestoEmpresa;

  Personal({
    this.idPersonalHospital,
    this.numeroDeEmpleado,
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.apellidoDeCasada,
    this.nit,
    this.dpi,
    this.telefono,
    this.direccion,
    this.departamentoEmpresa,
    this.puestoEmpresa
  });

  factory Personal.fromJson(dynamic json){
    return Personal(
        idPersonalHospital: json["idPersonalHospital"],
      numeroDeEmpleado: json["numeroDeEmpleado"],
      primerNombre: json["primerNombre"],
      segundoNombre: json["segundoNombre"],
      primerApellido: json["primerApellido"],
      segundoApellido: json["segundoApellido"],
      apellidoDeCasada: json["apellidoDeCasada"],
      nit: json["nit"],
      dpi: json["dpi"],
      telefono: json["telefono"],
      direccion: json["direccion"],
      departamentoEmpresa: DepartamentoEmpresa.fromJson(json["departamentoEmpresa"]),
      puestoEmpresa: PuestoEmpresa.fromJson(json["puestoEmpresa"])
    );
  }

  Map<String,dynamic> toJson()=>{
    'idPersonalHospital':idPersonalHospital,
    'numeroDeEmpleado':numeroDeEmpleado,
    'primerNombre':primerNombre,
    'segundoNombre':segundoNombre,
    'primerApellido':primerApellido,
    'segundoApellido':segundoApellido,
    'apellidoDeCasada':apellidoDeCasada,
    'nit':nit,
    'dpi':dpi,
    'telefono':telefono,
    'direccion':direccion,
    'departamentoEmpresa':departamentoEmpresa.toJson(),
    'puestoEmpresa':puestoEmpresa.toJson()
  };
}