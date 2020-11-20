import 'dart:convert';

import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/Medicina.dart';
import 'package:clinica_frontend/Models/Receta.dart';
import 'package:clinica_frontend/ViewModel/RecetasVM.dart';
import 'package:clinica_frontend/Views/Pacientes/newEditMedicamentoDialog.dart';
import 'package:flutter/material.dart';

class MedicamentosDialog extends StatefulWidget{
  MedicamentosDialog({Key key,this.title,this.cita,this.medicinas}):super(key: key);

  final title;
  CitaPaciente cita;
  List<Medicina> medicinas;

  @override
  State<StatefulWidget> createState() {
    return new MedicamentosDialogState();
  }
}

class MedicamentosDialogState extends State<MedicamentosDialog>{
  Medicina selected;
  RecetasVM _recetasVM=new RecetasVM();
  Receta tempReceta;


  @override
  void initState() {
    selected=widget.medicinas.elementAt(0);
    super.initState();
  }

  void showAddMedicamentoDialog(){
    showDialog(
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context){
        return NewEditMedicamento(
          title: "Medicamento",
          medicinas: widget.medicinas,
        );
      }
    ).then((value) {
      if(value!=null){
        if(value[0]){
          if(widget.cita.recetas.isEmpty){
            Receta receta=new Receta(
              citaPaciente: new CitaPaciente(
                idCitaPaciente: widget.cita.idCitaPaciente
              ),
              detallesRecetas: [value[1]]
            );

            widget.cita.recetas.add(receta);
          }else{
            widget.cita.recetas.first.citaPaciente=new CitaPaciente(
              idCitaPaciente: widget.cita.idCitaPaciente
            );

            widget.cita.recetas.first.detallesRecetas.add(value[1]);
          }

          setState(() {
          });
        }
      }
    });
  }

  Future<void> saveReceta() async {
    List response=await _recetasVM.add(widget.cita.recetas.first);

    if(response[0]==1){
      widget.cita.recetas.first=response[1];
    }

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(widget.cita.recetas.first.detallesRecetas.elementAt(index).medicina.descripcion),
                    subtitle: Text("Cantidad: "+widget.cita.recetas.first.detallesRecetas.elementAt(index).cantidad.toString()),
                  );
                },
                itemCount: widget.cita.recetas.length==0?0:widget.cita.recetas.first.detallesRecetas.length,
              ),
              FlatButton(
                child: Text("Agregar medicamento"),
                onPressed: (){
                  showAddMedicamentoDialog();
                },
              ),
            ],
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
          child: Text("Guardar"),
          onPressed: (){
            saveReceta();
            //Navigator.pop(context,[true]);
          },
        )
      ],
    );
  }

}