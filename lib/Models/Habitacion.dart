import 'package:clinica_frontend/Models/NivelEdificio.dart';
import 'package:clinica_frontend/Models/TipoHabitacion.dart';
import 'package:clinica_frontend/Models/Ubicacion.dart';

class Habitacion{
  int _idHabitacion;
  bool _habitacionDisponible;
  String _descripcion;
  Ubicacion _ubicacion;
  bool _activo;
  TipoHabitacion _tipoHabitacion;
  NivelEdificio _nivelEdificio;

  Habitacion(this._idHabitacion, this._habitacionDisponible, this._descripcion,
      this._ubicacion, this._activo, this._tipoHabitacion, this._nivelEdificio);

  factory Habitacion.fromJson(dynamic json){

    return Habitacion(
        json["idHabitacion"],
        json["habitacionDisponible"],
        json["descripcion"],
        new Ubicacion.fromJson(json["ubicacion"]),
        json["activo"],
        new TipoHabitacion.fromJson(json["tipoHabitacion"]),
        new NivelEdificio.fromJson(json["nivelEdificio"])
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'idHabitacion': _idHabitacion,
        'habitacionDisponible': _habitacionDisponible,
        'descripcion':_descripcion,
        'ubicacion':_ubicacion.toJson(),
        'activo':_activo,
        'tipoHabitacion':_tipoHabitacion.toJson(),
        'nivelEdificio':_nivelEdificio.toJson()
      };

  NivelEdificio get nivelEdificio => _nivelEdificio;

  set nivelEdificio(NivelEdificio value) {
    _nivelEdificio = value;
  }

  TipoHabitacion get tipoHabitacion => _tipoHabitacion;

  set tipoHabitacion(TipoHabitacion value) {
    _tipoHabitacion = value;
  }

  bool get activo => _activo;

  set activo(bool value) {
    _activo = value;
  }

  Ubicacion get ubicacion => _ubicacion;

  set ubicacion(Ubicacion value) {
    _ubicacion = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  bool get habitacionDisponible => _habitacionDisponible;

  set habitacionDisponible(bool value) {
    _habitacionDisponible = value;
  }

  int get idHabitacion => _idHabitacion;

  set idHabitacion(int value) {
    _idHabitacion = value;
  }
}