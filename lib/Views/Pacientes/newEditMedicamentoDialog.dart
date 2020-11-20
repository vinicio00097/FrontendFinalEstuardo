import 'package:clinica_frontend/Models/DetallesReceta.dart';
import 'package:clinica_frontend/Models/Medicina.dart';
import 'package:flutter/material.dart';

class NewEditMedicamento extends StatefulWidget{
  NewEditMedicamento({Key key,this.title,this.medicinas}):super(key: key);

  final title;
  List<Medicina> medicinas;
  @override
  State<StatefulWidget> createState() {
    return new NewEditMedicamentoState();
  }
}

class NewEditMedicamentoState extends State<NewEditMedicamento>{
  var kform=new GlobalKey<FormState>();
  var cantidadController=new TextEditingController();
  Medicina selected;

  @override
  void initState() {
    selected=widget.medicinas.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        width: 200,
        child: SingleChildScrollView(
          child: Form(
            key: kform,
            child: Column(
              children: [
                TextFormField(
                  controller: cantidadController,
                  maxLength: 2,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                      labelText: "Cantidad"
                  ),
                  validator: (val){
                    if(!RegExp("\^[\\d]+\$").hasMatch(val)){
                      return "Cantidad solo debe ser numerica.";
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  value: selected,
                  decoration: InputDecoration(
                      labelText: "Medicinas"
                  ),
                  onChanged: (val){
                    selected=val;
                  },
                  items: widget.medicinas.map((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.descripcion),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Cancelar"),
          onPressed: (){
            Navigator.pop(context,[false]);
          },
        ),
        FlatButton(
          child: Text("Agregar"),
          onPressed: (){
            if(kform.currentState.validate()){
              var detalle=new DetallesReceta(
                medicina: selected,
                cantidad: int.parse(cantidadController.text)
              );
              Navigator.pop(context,[true,detalle]);
            }
          },
        )
      ],
    );
  }

}