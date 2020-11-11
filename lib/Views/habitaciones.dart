

import 'dart:convert';
import 'dart:developer';
import 'dart:html';
import 'dart:ui';

import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:clinica_frontend/Models/NivelEdificio.dart';
import 'package:clinica_frontend/Models/TipoHabitacion.dart';
import 'package:clinica_frontend/Models/Ubicacion.dart';
import 'package:clinica_frontend/Services/TiposHabitacionService.dart';
import 'package:clinica_frontend/ViewModel/HabitacionesVM.dart';
import 'package:clinica_frontend/ViewModel/NivelesEdificioVM.dart';
import 'package:clinica_frontend/ViewModel/TiposHabitacionVM.dart';
import 'package:clinica_frontend/ViewModel/UbicacionesVM.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

typedef void onChangeSwitch(bool State);

class ActiveSwitchToggle extends StatefulWidget{
  ActiveSwitchToggle({Key key,this.title,this.value,this.onChange}): super(key: key);

  final title;
  bool value;
  onChangeSwitch onChange;

  @override
  State<StatefulWidget> createState() {
    return new ActiveSwitchState();
  }
}

class ActiveSwitchState extends State<ActiveSwitchToggle>{
  bool currValue;
  @override
  void initState() {
    currValue=widget.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: currValue,
      title: Text(widget.title),
      onChanged: (newVal){
        currValue=newVal;
        setState(() {
        });

        widget.onChange(newVal);
      },
    );
  }
}

class HabitacionesPage extends StatefulWidget{
  HabitacionesPage({Key key,this.title}): super(key:key);

  final title;

  @override
  State<StatefulWidget> createState() {
    return new HabitacionesPageState();
  }
}

class HabitacionesPageState extends State<HabitacionesPage>{
  HabitacionesVM _habitacionesVM=new HabitacionesVM();
  TiposHabitacionVM _tiposHabitacionVM=new TiposHabitacionVM();
  NivelesEdificioVM _nivelesEdificioVM=new NivelesEdificioVM();
  UbicacionVM _ubicacionVM=new UbicacionVM();

  bool AllLoaded=false;

  List<Habitacion> _habitacionesData=[];
  List<TipoHabitacion> _tiposHabitacionData=[];
  List<NivelEdificio> _nivelesEdificioData=[];
  List<Ubicacion> _ubicacionesData=[];

  @override void initState() {
    loadData();
    super.initState();
  }

  loadData()async{
    List responses=await Future.wait([_habitacionesVM.getAllHabitaciones(),
      _tiposHabitacionVM.getAll(),
      _nivelesEdificioVM.getAll(),
      _ubicacionVM.getAll()
    ]);

    AllLoaded=true;

    if(responses[0][0]==1&&
        responses[1][0]==1&&
        responses[2][0]==1&&
        responses[3][0]==1
    ){
      _habitacionesData=responses[0][1];
      _tiposHabitacionData=responses[1][1];
      _nivelesEdificioData=responses[2][1];
      _ubicacionesData=responses[3][1];

      setState(() {
      });
    }
  }


  List<Widget> returnItems(){
    List<Widget> items=[];

    for(var item in _habitacionesData){
      items.add(
          Card(
            elevation: 5,
            child: Stack(children: [
              Positioned(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(item.descripcion),
                    ),
                    ListTile(
                      title: Text("Tipo de Habitación"),
                      subtitle: Text(item.tipoHabitacion.descripcion),
                    ),
                    ListTile(
                      title: Text("Ubicación"),
                      subtitle: Text(item.ubicacion.descripcion),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        editHabitacion(item);
                      },
                    )
                  ],
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color:item.habitacionDisponible?Colors.green:Colors.red,
                      shape: BoxShape.circle
                  ),
                ),
              )
            ]),
          )
      )  ;
    }
    return items;
  }

  void editHabitacion(Habitacion habitacion){
    TextEditingController descripcionController=new TextEditingController(text: habitacion.descripcion);
    bool active=habitacion.activo;
    TipoHabitacion tipoHabitacion=_tiposHabitacionData.where((element) => element.idTipoHabitacion==habitacion.tipoHabitacion.idTipoHabitacion).first;
    NivelEdificio nivelEdificio=_nivelesEdificioData.where((element) => element.idNivelEdificio==habitacion.nivelEdificio.idNivelEdificio).first;
    Ubicacion ubicacion=_ubicacionesData.where((element) => element.idUbicacion==habitacion.ubicacion.idUbicacion).first;

    var keyHabitacion=new GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (context){
          return new AlertDialog(
            title: Text("Edición de habitación"),
            content: SingleChildScrollView(
              child: Form(
                key: keyHabitacion,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Disponible: "),
                      subtitle: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: habitacion.habitacionDisponible?Colors.green:Colors.red
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: descripcionController,
                      maxLength: 30,
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                        labelText: "Descripción"
                      ),
                      validator: (text){
                        if(text.isEmpty){
                          return "Campo obligatorio.";
                        }},
                    ),
                    DropdownButtonFormField<TipoHabitacion>(
                        decoration: InputDecoration(
                            labelText: "Tipo de habitación"
                        ),
                      value: tipoHabitacion,
                      onChanged: (item){
                          tipoHabitacion=item;
                      },
                      items: _tiposHabitacionData.map<DropdownMenuItem<TipoHabitacion>>((tipohabitacion){
                        return DropdownMenuItem<TipoHabitacion>(
                          value: tipohabitacion,
                          child: Text(tipohabitacion.descripcion),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<NivelEdificio>(
                      decoration: InputDecoration(
                          labelText: "Niveles de edificio"
                      ),
                      value: nivelEdificio,
                      onChanged: (item){
                        nivelEdificio=item;
                      },
                      items: _nivelesEdificioData.map<DropdownMenuItem<NivelEdificio>>((nivelEdificio){
                        return DropdownMenuItem<NivelEdificio>(
                          value: nivelEdificio,
                          child: Text(nivelEdificio.descripcion),
                        );
                      }).toList(),
                    ),
                    DropdownButtonFormField<Ubicacion>(
                      decoration: InputDecoration(
                          labelText: "Ubicaciones"
                      ),
                      value: ubicacion,
                      onChanged: (item){
                        ubicacion=item;
                      },
                      items: _ubicacionesData.map<DropdownMenuItem<Ubicacion>>((ubicacion){
                        return DropdownMenuItem<Ubicacion>(
                          value: ubicacion,
                          child: Text(ubicacion.descripcion),
                        );
                      }).toList(),
                    ),
                    ActiveSwitchToggle(
                      title: "Activa",
                      value: active,
                      onChange: (newVal){
                        setState(() {
                          active=newVal;
                        });
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
                  Navigator.pop(context,false);
                },
              ),
              FlatButton(
                child: Text("Guardar"),
                onPressed: (){
                  if(keyHabitacion.currentState.validate()){
                    Navigator.pop(context,true);
                  }
                },
              )
            ],
          );
        },
        barrierDismissible: true
    ).then((value) async {
      if(value){
        Habitacion edited=new Habitacion(
            habitacion.idHabitacion, habitacion.habitacionDisponible,
            descripcionController.text, ubicacion,
            active, tipoHabitacion, nivelEdificio);

        List result=await _habitacionesVM.update(edited);

        if(result[0]==1){
          habitacion.descripcion=edited.descripcion;
          habitacion.habitacionDisponible=edited.habitacionDisponible;
          habitacion.ubicacion=edited.ubicacion;
          habitacion.activo=edited.activo;
          habitacion.tipoHabitacion=edited.tipoHabitacion;
          habitacion.nivelEdificio=edited.nivelEdificio;

          setState(() {
          });
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var columnCount=0;

    if(width<560){
      columnCount=1;
    }else if(width>=560&&width<960){
      columnCount=2;
    }else if(width>=960&&width<1280){
      columnCount=3;
    }else if(width>=1280&&width<1920){
      columnCount=4;
    }else{
      columnCount=5;
    }

    return Scaffold(
      appBar: AppBar(
        bottom: !AllLoaded?PreferredSize(
          preferredSize: Size(double.infinity,1.0),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ):null,
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: columnCount,
        children: returnItems(),
      ),
    );
  }

}