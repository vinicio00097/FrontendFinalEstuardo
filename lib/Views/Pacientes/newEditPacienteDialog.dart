

import 'dart:convert';

import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Models/PacienteInternado.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:clinica_frontend/Views/Pacientes/internarWidget.dart';
import 'package:clinica_frontend/Views/Pacientes/newEditCitaDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewEditPaciente extends StatefulWidget{
  NewEditPaciente({
    Key key,
    this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.dpi,
    this.nit,
    this.toEdit,
    this.habitaciones,
    this.personal
  }):super(key:key);

  var primerNombre;
  var segundoNombre;
  var primerApellido;
  var segundoApellido;
  var nit;
  var dpi;
  Paciente toEdit;
  List<Habitacion> habitaciones;
  List<Personal> personal;

  @override
  State<StatefulWidget> createState() {
    return new NewEditPacienteState();
  }

}

class NewEditPacienteState extends State<NewEditPaciente>{
  var _kForm=new GlobalKey<FormState>();
  TextEditingController _primerNombreController,_segundoNombreController,_primerApellidoController,_segundoApellidoContoller,
  _dpiController,_nitController;
  bool _internate=false;
  DateTime currdate=new DateTime.now();
  Habitacion selectedHabitacion;
  List<CitaPaciente> citasPaciente=[];

  @override
  void initState() {
    _primerNombreController=new TextEditingController(text: widget.primerNombre);
    _segundoNombreController=new TextEditingController(text: widget.segundoNombre);
    _primerApellidoController=new TextEditingController(text: widget.primerApellido);
    _segundoApellidoContoller=new TextEditingController(text: widget.segundoApellido);
    _dpiController=new TextEditingController(text: widget.dpi);
    _nitController=new TextEditingController(text: widget.nit);

    super.initState();
  }


  List<Widget> generateCitas(){
    List<Widget> citas=[];
    int count=1;
    for(var item in citasPaciente){
      citas.add(Row(
        children: [
          Expanded(
            child: ListTile(
              leading: Text(count.toString()),
              title: Text("Fecha y hora de cita"),
              subtitle: Text(item.fechaCita.toString()),
            ),
          ),
          Expanded(
            child: ListTile(
              title: Text("Médico a atender"),
              subtitle: Text(item.personal.primerNombre+" "+item.personal.segundoNombre+" "+item.personal.primerApellido+" "+item.personal.segundoApellido),
            ),
          )
        ],
      ));

      count++;
    }

    return citas;
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: Text("Nuevo paciente"),
      content: Container(
        width: 400,
        child: SingleChildScrollView(
          child: Form(
            key: _kForm,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _primerNombreController,
                        maxLength: 30,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                            labelText: "Primer nombre"
                        ),
                        validator: (text){
                          if(text.isEmpty||RegExp("\^[\\s]+\$").hasMatch(text)){
                            return "Primer nombre es requerido.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _segundoNombreController,
                        maxLength: 30,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                          labelText: "Segundo nombre"
                        ),
                        validator: (text){
                          if(text.isEmpty||RegExp("\^[\\s]+\$").hasMatch(text)){
                            return "Segundo nombre es requerido.";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _primerApellidoController,
                        maxLength: 30,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                            labelText: "Primer apellido"
                        ),
                        validator: (text){
                          if(text.isEmpty||RegExp("\^[\\s]+\$").hasMatch(text)){
                            return "Primer apellido es requerido.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _segundoApellidoContoller,
                        maxLength: 30,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                            labelText: "Segundo apellido"
                        ),
                        validator: (text){
                          if(text.isEmpty||RegExp("\^[\\s]+\$").hasMatch(text)){
                            return "Segundo apellido es requerido.";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nitController,
                        maxLength: 15,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                            labelText: "NIT"
                        ),
                        validator: (text){
                          if(text.isEmpty||RegExp("\^[\\s]+\$").hasMatch(text)){
                            return "NIT es requerido.";
                          }else if(!RegExp("\^[\\d]+\$").hasMatch(text)){
                            return "NIT debe únicamente numérico";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _dpiController,
                        maxLength: 15,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                            labelText: "DPI"
                        ),
                        validator: (text){

                          if(text.isEmpty||RegExp("\^[\\s]+\$").hasMatch(text)){
                            return "DPI es requerido.";
                          }else if(!RegExp("\^[\\d]+\$").hasMatch(text)){
                            return "DPI debe únicamente numérico";
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                widget.toEdit==null?widget.habitaciones.where((element) => element.habitacionDisponible).length>0?CheckboxListTile(
                  value: _internate,
                  title: Text("Internar"),
                  onChanged: (newVal){
                    _internate=newVal;
                    currdate=new DateTime.now();
                    selectedHabitacion=widget.habitaciones[0];

                    setState(() {
                    });
                  },
                ):ListTile(
                  title: Text("No se puede internar el paciente porque no hay habitaciones disponibles."),
                ) :null,
                _internate?InternarWidget(
                  habitaciones: widget.habitaciones,
                  currdate: currdate,
                  onChangeHabitacion: (newVal){
                    selectedHabitacion=newVal;
                  },
                ):null
              ].where((element) => element!=null).toList(),
            ),
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Cancelar"),
          onPressed: (){
            Navigator.of(context).pop([false]);
          },
        ),
        FlatButton(
          child: Text("Guardar"),
          onPressed: (){
            if(_kForm.currentState.validate()){
              
              Paciente newPaciente=new Paciente(
                idPaciente: widget.toEdit!=null?widget.toEdit.idPaciente:null,
                  primerNombre: _primerNombreController.text,
                  segundoNombre: _segundoNombreController.text,
                  primerApellido: _primerApellidoController.text,
                  segundoApellido: _segundoApellidoContoller.text,
                  dpi: _dpiController.text,
                  nit: _nitController.text,
                internados: _internate?[new PacienteInternado(fechaIngreso: currdate,habitacion: selectedHabitacion)]:[]
              );

              Navigator.of(context).pop([true,newPaciente]);
            }
          },
        )
      ],
    );
  }

}