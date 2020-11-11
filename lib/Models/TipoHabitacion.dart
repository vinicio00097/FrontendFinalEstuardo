class TipoHabitacion{
  int _idTipoHabitacion;
  String _descripcion;
  bool _activo;

  TipoHabitacion(this._idTipoHabitacion, this._descripcion, this._activo);

  factory TipoHabitacion.fromJson(dynamic json){
    return TipoHabitacion(json["idTipoHabitacion"], json["descripcion"], json["activo"]);
  }

  Map<String, dynamic> toJson() =>
      {
        'idTipoHabitacion': _idTipoHabitacion,
        'descripcion': _descripcion,
        'activo':_activo,
      };

  bool get activo => _activo;

  set activo(bool value) {
    _activo = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  int get idTipoHabitacion => _idTipoHabitacion;

  set idTipoHabitacion(int value) {
    _idTipoHabitacion = value;
  }
}