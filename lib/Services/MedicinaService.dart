import 'package:clinica_frontend/Dao/IMedicinaDao.dart';
import 'package:clinica_frontend/Models/Medicina.dart';
import 'package:http/http.dart' as http;

class MedicinaService implements IMedicinaDao{
  String _baseURL="https://bitdatasolution.com/clinica/";
  String _baseURL2="http://localhost:8081/";

  @override
  Future add(Medicina obj) {
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
          "${_baseURL}Medicinas"
      );

      if(response.statusCode==200){
        return [1,response.body];
      }else{
        return [0];
      }
    }catch(e){
      print(e);
      return [2];
    }
  }

  @override
  Future update(Medicina obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

}