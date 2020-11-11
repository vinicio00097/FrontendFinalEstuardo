class NivelEdificio{
  int _idNivelEdificio;
  String _descripcion;

  NivelEdificio(this._idNivelEdificio, this._descripcion);

  factory NivelEdificio.fromJson(dynamic json){
    return NivelEdificio(json["idNivelEdificio"], json["descripcion"]);
  }

  Map<String, dynamic> toJson() =>
      {
        'idNivelEdificio': _idNivelEdificio,
        'descripcion': _descripcion,
      };

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  int get idNivelEdificio => _idNivelEdificio;

  set idNivelEdificio(int value) {
    _idNivelEdificio = value;
  }
}