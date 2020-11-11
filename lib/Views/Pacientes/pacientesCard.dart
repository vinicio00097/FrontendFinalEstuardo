import 'package:clinica_frontend/Models/Paciente.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PacientesCard extends StatelessWidget{

  const PacientesCard({
    Key key,
    this.paciente,
    this.onEdit,
    this.onDelete,
    this.onInternalHistory,
    this.onInternar,
    this.ondeAlta,
    this.onCitas
  }):super(key: key);

  final Paciente paciente;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onInternalHistory;
  final VoidCallback onInternar;
  final VoidCallback ondeAlta;
  final VoidCallback onCitas;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Stack(children: [
        Positioned(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text("Nombres"),
                      subtitle: Text(paciente.primerNombre+" "+paciente.segundoNombre),
                    ),
                  ),
                  Expanded(
                      child: ListTile(
                        title: Text("Apellidos"),
                        subtitle: Text(paciente.primerApellido+" "+paciente.segundoApellido),
                      )
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text("Nit"),
                      subtitle: Text(paciente.nit),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text("Dpi"),
                      subtitle: Text(paciente.dpi),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Tooltip(
                    message: "Editar",
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: (){
                        onEdit();
                      },
                    ),
                  ),
                  Tooltip(
                    child: IconButton(
                      icon: Icon(Icons.today),
                      onPressed: (){
                        onCitas();
                      },
                    ),
                    message: "Citas",
                  ),
                  Tooltip(
                    child: IconButton(
                      icon: Icon(Icons.update),
                      onPressed: (){
                        onInternalHistory();
                      },
                    ),
                    message: "Historial de internación",
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: IconButton(
            icon: Icon(Icons.clear_sharp),
            onPressed: (){
              onDelete();
            },
          ),
        ),
        paciente.internados.where((element) => element.fechaIngreso!=null&&element.fechaSalida==null).length>0?Positioned(
          bottom: 15,
          right: 15,
          child: FlatButton(
            child: Text("Dar de alta"),
            onPressed: (){
              ondeAlta();
            },
          ),
        ):Positioned(
          bottom: 15,
          right: 15,
          child: FlatButton(
            child: Text("Internar"),
            onPressed: (){
              onInternar();
            },
          ),
        )
      ]),
    );
  }

}