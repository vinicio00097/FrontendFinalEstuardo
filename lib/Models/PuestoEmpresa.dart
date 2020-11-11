class PuestoEmpresa{
  int idPuesto;
  String descripcion;

  PuestoEmpresa({this.idPuesto, this.descripcion});

  factory PuestoEmpresa.fromJson(dynamic json){
    return PuestoEmpresa(idPuesto: json["idPuesto"],descripcion: json["descripcion"]);
  }

  Map<String,dynamic> toJson()=>{
    'idPuesto':idPuesto,
    'descripcion':descripcion
  };
}