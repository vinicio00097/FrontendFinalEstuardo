import 'package:clinica_frontend/Models/PacienteInternado.dart';
import 'package:flutter/material.dart';

class InternadoHistory extends StatefulWidget{
  InternadoHistory({
    Key key,this.title,
    this.internados
  }):super(key: key);

  final title;
  List<PacienteInternado> internados;

  @override
  State<StatefulWidget> createState() {
    return new InternadoHistoryState();
  }
}

class InternadoHistoryState extends State<InternadoHistory>{

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Container(
          width: 400,
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return Row(
                children: [
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text("Fecha ingreso"),
                      subtitle: Text(widget.internados.elementAt(index).fechaIngreso.toString().split(" ")[0]),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text("Fecha salida"),
                      subtitle: Text(widget.internados.elementAt(index).fechaSalida==null?
                      "-Internado-":widget.internados.elementAt(index).fechaSalida.toString().split(" ")[0]),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      dense: true,
                      title: Text("Habitación"),
                      subtitle: Text(widget.internados.elementAt(index).habitacion.descripcion),
                    ),
                  )
                ],
              );
            },
            itemCount: widget.internados.length,
          ),
        ),
      ),
    );
  }

}