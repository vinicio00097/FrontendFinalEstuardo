import 'package:clinica_frontend/Dao/IPersonalDao.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:http/http.dart' as http;

class PersonalService implements IPersonalDao{
  @override
  Future add(Personal obj) {
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
          "http://localhost:8081/Personal"
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
  Future update(Personal obj) {
    // TODO: implement update
    throw UnimplementedError();
  }

}