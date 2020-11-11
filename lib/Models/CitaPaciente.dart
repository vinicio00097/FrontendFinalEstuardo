import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Models/Personal.dart';

class CitaPaciente{
  int idCitaPaciente;
  DateTime fechaCita;
  Personal personal;
  Paciente paciente;


  CitaPaciente({this.idCitaPaciente, this.fechaCita, this.personal,this.paciente});

  factory CitaPaciente.fromJson(dynamic json){
    return CitaPaciente(idCitaPaciente: json["idCitaPaciente"],
        fechaCita: json["fechaCita"]!=null?DateTime.parse(json["fechaCita"]):json["fechaCita"],
        personal: Personal.fromJson(json["personal"]));
  }

  Map<String,dynamic> toJson()=>{
    'idCitaPaciente':idCitaPaciente,
    'fechaCita':fechaCita!=null?fechaCita.toString().split(".")[0]:null,
    'personal':personal,
    'paciente':paciente
  };
}