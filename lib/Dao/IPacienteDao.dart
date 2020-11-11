import 'package:clinica_frontend/Dao/ICRUD.dart';
import 'package:clinica_frontend/Models/Paciente.dart';

abstract class IPacienteDao extends ICRUD<Paciente>{
  Future<dynamic> updateInternado(Paciente obj);
}