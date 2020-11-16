import 'package:clinica_frontend/Dao/ITipoHabitacionDao.dart';
import 'package:clinica_frontend/Models/TipoHabitacion.dart';
import 'package:http/http.dart' as http;

class TiposHabitacion implements ITipoHabitacionDao{
  String _baseURL="https://bitdatasolution.com/clinica/";

  @override
  Future add(TipoHabitacion obj) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future getAll() async {
    try{
      var response=await http.get(
          "${_baseURL}TiposHabitacion"
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      return [2];
    }
  }

  @override
  Future update(TipoHabitacion obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

}