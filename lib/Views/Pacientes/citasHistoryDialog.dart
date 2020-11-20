import 'package:clinica_frontend/Models/CitaPaciente.dart';
import 'package:clinica_frontend/Models/Medicina.dart';
import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:clinica_frontend/Models/Personal.dart';
import 'package:clinica_frontend/ViewModel/CitasVM.dart';
import 'package:clinica_frontend/Views/Pacientes/medicamentosDialog.dart';
import 'package:clinica_frontend/Views/Pacientes/newEditCitaDialog.dart';
import 'package:flutter/material.dart';

class CitasHistory extends StatefulWidget{
  CitasHistory({Key key,this.title,this.citas,this.personal,this.idPaciente,this.medicinas}):super(key: key);

  final title;
  final List<CitaPaciente> citas;
  final List<Personal> personal;
  final int idPaciente;
  List<Medicina> medicinas;

  @override
  State<StatefulWidget> createState() {
    return new CitasHistoryState();
  }
}

class CitasHistoryState extends State<CitasHistory>{
  CitasVM _citasVM=new CitasVM();

  void newCita(){
    showDialog(
      context: context,
      builder: (context){
        return NewEditCita(
          title: "Nueva cita",
          personal: widget.personal,
          idPaciente: widget.idPaciente,
        );
      }
    ).then((value) async {
      if(value!=null){
        if(value[0]){
          List response=await _citasVM.add(value[1]);

          if(response[0]==1){
            widget.citas.add(response[1]);

            setState(() {
            });
          }
        }
      }
    });
  }

  Future<void> deleteCita(CitaPaciente cita) async {
    List response=await _citasVM.delete(cita.idCitaPaciente);

    if(response[0]==1){
      widget.citas.remove(cita);

      setState(() {
      });
    }
  }

  void editCita(CitaPaciente cita)async{
    showDialog(
      context: context,
      builder: (context){
        return NewEditCita(
          title: "Edición de cita",
          personal: widget.personal,
          toEdit: cita,
        );
      }
    ).then((value) async {
      if(value!=null){
        if(value[0]){
          cita.fechaCita=value[1].fechaCita;
          cita.personal=value[1].personal;
          cita.paciente=new Paciente(idPaciente: widget.idPaciente);

          List response=await _citasVM.update(cita);

          if(response[0]==1){
            setState(() {
            });
          }
        }
      }
    });
  }

  void showMedicamentos(CitaPaciente cita){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return MedicamentosDialog(
          title: "Medicamentos cita ${widget.citas.indexOf(cita)+1}",
          cita: cita,
          medicinas: widget.medicinas,
        );
      }
    ).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: Text((index+1).toString()),
                    title: Text("Fecha de cita"),
                    subtitle: Text(widget.citas[index].fechaCita.toString().split(".")[0]),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert_outlined),
                      onSelected: (val){
                        switch (val) {
                          case "eliminar":
                            deleteCita(widget.citas[index]);
                            break;
                          case "editar":
                            editCita(widget.citas[index]);
                            break;
                          case "medicamentos":
                            showMedicamentos(widget.citas[index]);
                            break;
                        }
                      },
                      itemBuilder: (context)=><PopupMenuEntry<String>>[
                        PopupMenuItem(
                          value: "eliminar",
                          child: Text("Eliminar"),
                        ),
                        PopupMenuItem(
                          value: "medicamentos",
                          child: Text("Medicamentos"),
                        ),
                        PopupMenuItem(
                          value: "editar",
                          child: Text("Editar"),
                        )
                      ],
                    ),
                  );
                },
                itemCount: widget.citas.length,
              ),
              FlatButton(
                child: Text("Agregar cita"),
                onPressed: (){
                  newCita();
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        FlatButton(
          child: Text("Cerrar"),
          onPressed: (){
            Navigator.pop(context,false);
          },
        ),
      ]
    );
  }

}