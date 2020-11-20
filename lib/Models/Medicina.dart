class Medicina{
  int idMedicina;
  String descripcion;
  String observaciones;
  bool activo;
  int existencia;

  Medicina({this.idMedicina, this.descripcion, this.observaciones,
      this.activo, this.existencia});

  factory Medicina.fromJson(dynamic json){
    return Medicina(
      idMedicina: json["idMedicina"],
      descripcion: json["descripcion"],
      observaciones: json["observaciones"],
      activo: json["activo"],
      existencia: json["existencia"]
    );
  }

  Map<String,dynamic> toJson()=>{
    "idMedicina":idMedicina,
    "descripcion":descripcion,
    "observaciones":observaciones,
    "activo":activo,
    "existencia":existencia
  };
}