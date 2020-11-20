import 'Medicina.dart';

class DetallesReceta{
  int idDetalleReceta;
  Medicina medicina;
  int cantidad;


  DetallesReceta({this.idDetalleReceta, this.medicina, this.cantidad});

  factory DetallesReceta.fromJson(dynamic json){
    return DetallesReceta(
      idDetalleReceta: json["idDetalleReceta"],
      medicina: Medicina.fromJson(json["medicina"]),
      cantidad: json["cantidad"]
    );
  }

  Map<String,dynamic> toJson()=>{
    "idDetalleReceta":idDetalleReceta,
    "medicina":medicina,
    "cantidad":cantidad
  };
}