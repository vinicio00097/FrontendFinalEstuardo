import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:clinica_frontend/Models/PacienteInternado.dart';
import 'package:clinica_frontend/Views/Pacientes/internarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternarDialog extends StatelessWidget{
  InternarDialog({
    Key key,this.title,
    this.habitaciones,
  }):super(key: key);

  final title;
  final List<Habitacion> habitaciones;
  DateTime currdate;
  Habitacion selectedHabitacion;
  bool firstTime=false;

  @override
  Widget build(BuildContext context) {
    if(!firstTime){
      if(habitaciones.where((element) => element.habitacionDisponible).length>0){
        selectedHabitacion=habitaciones.where((element) => element.habitacionDisponible).first;
      }

      firstTime=true;
    }
    return AlertDialog(
      title: Text(title),
      content: Container(
        width: 400,
        child: SingleChildScrollView(
          child: habitaciones.where((element) => element.habitacionDisponible).length>0?InternarWidget(
            onChangeHabitacion: (newVal){
              selectedHabitacion=newVal;
            },
            currdate: (currdate=new DateTime.now()),
            habitaciones: habitaciones,
          ):ListTile(
            title: Text("No se puede internar porque no hay habitaciones disponibles."),
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
        habitaciones.where((element) => element.habitacionDisponible).length>0?FlatButton(
          child: Text("Internar"),
          onPressed: (){
            PacienteInternado pacienteInternado=new PacienteInternado(
              fechaIngreso: currdate,
              habitacion: selectedHabitacion
            );

            Navigator.pop(context,[true,pacienteInternado]);
          },
        ):null
      ].where((element) => element!=null).toList(),
    );
  }

}