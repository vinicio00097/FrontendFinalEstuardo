import 'dart:convert';

import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:flutter/material.dart';

class NewEditCita extends StatefulWidget{
  NewEditCita({Key key,this.title,this.personal,this.idPaciente,this.toEdit}):super(key: key);

  final title;
  final List<Personal> personal;
  final int idPaciente;
  final CitaPaciente toEdit;

  @override
  State<StatefulWidget> createState() {
    return new NewEditCitaState();
  }
}

class NewEditCitaState extends State<NewEditCita>{
  TextEditingController fecha=new TextEditingController();
  TextEditingController hora=new TextEditingController();
  var kform=new GlobalKey<FormState>();
  Personal selectedPersonal;

  @override
  void initState() {
    print(widget.toEdit);
    if(widget.toEdit!=null){
      selectedPersonal=widget.personal.where((element) => element.idPersonalHospital==widget.toEdit.personal.idPersonalHospital).first;
      
      var datetimesplitted=widget.toEdit.fechaCita.toString().split(" ");
      var timesplitted=datetimesplitted[1].split(":");
      fecha.text=datetimesplitted[0];
      hora.text=timesplitted[0]+":"+timesplitted[1];
    }else{
      selectedPersonal=widget.personal[0];
    }
    super.initState();
  }

  void selectDate(){
    showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: widget.toEdit!=null?DateTime.parse(fecha.text):new DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30))
    ).then((value){
      if(value!=null){
        fecha.text=value.toString().split(" ")[0];
      }
    });
  }

  void selectTime(){
    showTimePicker(
      context:context,
      initialTime: widget.toEdit!=null?TimeOfDay.fromDateTime(DateTime.parse("2020-11-11 "+hora.text)):TimeOfDay.now()
    ).then((value){
      if(value!=null){
        hora.text=value.hour.toString()+ ":" +value.minute.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      content: Container(
        width: 300,
        child: SingleChildScrollView(
          child: Form(
            key: kform,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: fecha,
                        onTap: (){
                          selectDate();
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "Fecha"
                        ),
                        validator: (val){
                          if(val.isEmpty||RegExp("\^[\\s]+\$").hasMatch(val)){
                            return "Fecha es obligatorio";
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
                        controller: hora,
                        onTap: (){
                          selectTime();
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "Hora"
                        ),
                        validator: (val){
                          if(val.isEmpty||RegExp("\^[\\s]+\$").hasMatch(val)){
                            return "Hora es obligatorio";
                          }

                          return null;
                        },
                      ),
                    )
                  ],
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: "Personal disponible"
                  ),
                  value: selectedPersonal,
                  onChanged: (val){
                    selectedPersonal=val;
                  },
                  items: widget.personal.map((e) {
                    return DropdownMenuItem(
                      child: Text(e.primerNombre+" "+e.primerApellido+" - "+e.puestoEmpresa.descripcion),
                      value: e,
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
          child: Text("Guardar"),
          onPressed: (){
            hora.text.length>4?hora.text:hora.text="0"+hora.text;

            if(kform.currentState.validate()){
              CitaPaciente citapaciente=new CitaPaciente(
                paciente: new Paciente(idPaciente: widget.idPaciente),
                fechaCita: DateTime.parse(fecha.text+" "+hora.text),
                personal: selectedPersonal
              );

              Navigator.pop(context,[true,citapaciente]);
            }
          },
        )
      ],
    );
  }

}