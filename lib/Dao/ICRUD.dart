class ICRUD<T> {
  Future<dynamic> getAll(){}
  Future<dynamic> add(T obj){}
  Future<dynamic> delete(int id){}
  Future<dynamic> update(T obj){}
}