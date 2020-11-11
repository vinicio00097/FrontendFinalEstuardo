class Ubicacion{
  int _idUbicacion;
  String _descripcion;


  Ubicacion(this._idUbicacion, this._descripcion);

  factory Ubicacion.fromJson(dynamic json){
    return Ubicacion(json['idUbicacion'], json['descripcion']);
  }

  Map<String, dynamic> toJson() =>
      {
        'idUbicacion': _idUbicacion,
        'descripcion': _descripcion,

      };

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  int get idUbicacion => _idUbicacion;

  set idUbicacion(int value) {
    _idUbicacion = value;
  }
}