import 'dart:convert';
import 'dart:js_util';

import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:clinica_frontend/Models/Medicina.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Models/PacienteInternado.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:clinica_frontend/ViewModel/HabitacionesVM.dart';
import 'package:clinica_frontend/ViewModel/MedicinasVM.dart';
import 'package:clinica_frontend/ViewModel/PacientesVM.dart';
import 'package:clinica_frontend/ViewModel/PersonalVM.dart';
import 'package:clinica_frontend/Views/Pacientes/NewEditPacienteDialog.dart';
import 'package:clinica_frontend/Views/Pacientes/citasHistoryDialog.dart';
import 'package:clinica_frontend/Views/Pacientes/interadoHistoryDialog.dart';
import 'package:clinica_frontend/Views/Pacientes/internarDialog.dart';
import 'package:clinica_frontend/Views/Pacientes/pacientesCard.dart';
import 'package:flutter/material.dart';

class PacientesPage extends StatefulWidget{
  PacientesPage({Key key,this.title}):super(key:key);


  final title;
  @override
  State<StatefulWidget> createState() {
    return new PacientesState();
  }
}

class PacientesState extends State<PacientesPage>{
  PacientesVM _pacientesVM=new PacientesVM();
  PersonalVM _personalVM=new PersonalVM();
  HabitacionesVM _habitacionesVM=new HabitacionesVM();
  MedicinasVM _medicinasVM=new MedicinasVM();
  bool _allLoaded=false;

  List<Paciente> _pacientesData=[];
  List<Personal> _personalData=[];
  List<Habitacion> _habiacionesData=[];
  List<Medicina> _medicinasData=[];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future loadData() async {
    /*List responsePacientes=await _pacientesVM.getAll();
    List responsePersonal=await _personalVM.getAll();
    List responseHabitaciones=await _habitacionesVM.getAllHabitaciones();*/
    List responses= await Future.wait([ _pacientesVM.getAll(),_personalVM.getAll(),_habitacionesVM.getAllHabitaciones(),_medicinasVM.getAll()]);
    _allLoaded=true;

    if(responses[0][0]==1&&responses[1][0]==1&&responses[2][0]==1&&responses[3][0]==1){
      _pacientesData=responses[0][1];
      _personalData=responses[1][1];
      _habiacionesData=responses[2][1];
      _medicinasData=responses[3][1];

      setState(() {
      });
    }
  }

 List<Widget> _getPacientesList(){
    List<Widget> lista=[];

    for(var item in _pacientesData){
      lista.add(
        PacientesCard(
          paciente: item,
          onEdit: (){
            _edit(item);
          },
          onDelete: () async {
            List result=await _pacientesVM.delete(item.idPaciente);

            if(result[0]==1){
              if(result[0])
              _pacientesData.remove(item);

              setState(() {
              });
            }
          },
          onInternalHistory: (){
            if(item.internados.length>0){
              openHistoryInternal(item);
            }
          },
          onInternar: (){
            internarPatient(item);
          },
          ondeAlta: (){
            dischargePatient(item);
          },
          onCitas: (){
            //if(item.citas.length>0){
              openCitas(item);
            //}
          },
        )
      );
    }

    return lista;
  }

  void openCitas(Paciente paciente){
    showDialog(
      context: context,
      builder: (context){
        return CitasHistory(
          title: "Citas paciente ${paciente.primerNombre} ${paciente.segundoNombre}",
          citas: paciente.citas,
          personal: _personalData,
          idPaciente: paciente.idPaciente,
          medicinas: _medicinasData,
        );
      }
    ).then((value) {
      if(value!=null){
        if(value){
          print(value);
        }
      }
    });
  }

  void internarPatient(Paciente paciente){
    showDialog(
      context: context,
      builder: (context){
        return InternarDialog(
          habitaciones: _habiacionesData,
          title: "Internar a paciente",
        );
      }
    ).then((value) async {
      if(value!=null){
        if(value[0]){
          paciente.internados.add(value[1]);

          List response=await _pacientesVM.add(paciente);

          if(response[0]==1){
            value[1].habitacion.habitacionDisponible=false;

            paciente.internados=response[1].internados;
          }else{
            paciente.internados.remove(value[1]);
          }

          setState(() {
          });
        }
      }
    });
  }

  void dischargePatient(Paciente paciente){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Dar de alta"),
          content: Text("Desea dar de alta al paciente: ${paciente.primerNombre+" "+
              paciente.segundoNombre+" "+
              paciente.primerApellido+" "+
              paciente.segundoApellido} ? "),
          actions: [
            FlatButton(
              child: Text("Cancelar"),
              onPressed: (){
                Navigator.pop(context,false);
              },
            ),
            FlatButton(
              child: Text("Aceptar"),
              onPressed: (){
                Navigator.pop(context,true);
              },
            )
          ],
        );
      }
    ).then((value) async {
      if(value!=null){
        if(value){
          List response=await _pacientesVM.updateInternado(paciente);

          if(response[0]==1){

            _habiacionesData.where((element) => element.idHabitacion==paciente.internados.where((element) => element.fechaSalida==null).first.habitacion.idHabitacion).first.habitacionDisponible=true;

            paciente.internados=response[1].internados;

            setState(() {
            });
          }
        }
      }
    });
  }

  void openHistoryInternal(Paciente paciente){
    showDialog(
      context: context,
      builder: (context){
        return InternadoHistory(
          title: "Historial de internaciones",
          internados: paciente.internados,
        );
      }
    ).then((value){

    });
  }

  void _addNew(){
    showDialog(
      context: context,
      builder: (context){
        return NewEditPaciente(
          habitaciones:_habiacionesData
        );
      }
    ).then((value) async {
      if(value[0]){

        List response=await _pacientesVM.add(value[1]);


        if(response[0]==1){
          _pacientesData.add(response[1]);

          setState(() {
          });
        }
      }
    });
  }

  void _edit(Paciente paciente){
    print(paciente.idPaciente);

    showDialog(
      context: context,
      builder: (context){
        return NewEditPaciente(
          primerNombre: paciente.primerNombre,
          segundoNombre: paciente.segundoNombre,
          primerApellido: paciente.primerApellido,
          segundoApellido: paciente.segundoApellido,
          dpi: paciente.dpi,
          nit: paciente.nit,
          toEdit:paciente
        );
      }
    ).then((value) async {
      if(value!=null){
        if(value[0]){
          Paciente result=value[1];


          List response=await _pacientesVM.update(result);

          if(response[0]==1){
            paciente.primerNombre=result.primerNombre;
            paciente.segundoNombre=result.segundoNombre;
            paciente.primerApellido=result.primerApellido;
            paciente.segundoApellido=result.segundoApellido;
            paciente.dpi=result.dpi;
            paciente.nit=result.nit;
          }

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
        elevation: 0,
        bottom: !_allLoaded?PreferredSize(
          preferredSize: Size(double.infinity, 1.0),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ):null,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        primary: false,
        crossAxisCount: columnCount,
        children: _getPacientesList(),
      ),
      floatingActionButton: _allLoaded?FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: (){
          _addNew();
        },
      ):null,
    );
  }

}