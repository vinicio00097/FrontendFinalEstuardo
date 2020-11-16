import 'package:clinica_frontend/Dao/INivelEdificioDao.dart';
import 'package:clinica_frontend/Models/NivelEdificio.dart';
import 'package:http/http.dart' as http;

class NivelEdificioService implements INivelEdificioDao{
  String _baseURL="https://bitdatasolution.com/clinica/";
  @override
  Future add(NivelEdificio obj) {
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
          "${_baseURL}NivelesEdificio"
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
  Future update(NivelEdificio obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

}