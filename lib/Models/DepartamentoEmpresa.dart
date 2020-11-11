class DepartamentoEmpresa{
  int idDepartamentoEmpresa;
  String descripcion;

  DepartamentoEmpresa({this.idDepartamentoEmpresa, this.descripcion});

  factory DepartamentoEmpresa.fromJson(dynamic json){
    return DepartamentoEmpresa(idDepartamentoEmpresa: json["idDepartamentoEmpresa"],descripcion: json["descripcion"]);
  }

  Map<String,dynamic> toJson()=>{
    'idDepartamentoEmpresa':idDepartamentoEmpresa,
    'descripcion':descripcion
  };
}