import 'package:clinica_frontend/Dao/IUbicacionDao.dart';
import 'package:clinica_frontend/Models/Ubicacion.dart';
import 'package:http/http.dart' as http;

class UbicacionService implements IUbicacionDao{
  String _baseURL="https://bitdatasolution.com/clinica/";
  @override
  Future add(Ubicacion obj) {
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
          "${_baseURL}Ubicaciones"
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
  Future update(Ubicacion obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

}