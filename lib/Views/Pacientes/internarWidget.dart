import 'dart:convert';

import 'package:clinica_frontend/Models/Habitacion.dart';
import 'package:flutter/material.dart';


typedef void OnChangeHabitacion(Habitacion habitacion);

class InternarWidget extends StatelessWidget{
  InternarWidget({
    Key key,
    this.currdate,
    this.habitaciones,
    this.onChangeHabitacion
  }):super(key: key);

  final DateTime currdate;
  final List<Habitacion> habitaciones;
  final OnChangeHabitacion onChangeHabitacion;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: new TextEditingController(text: (currdate).toString().split(".")[0]),
                readOnly: true,
                decoration: InputDecoration(
                    labelText: "Fecha de ingreso"
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            Expanded(
              child: DropdownButtonFormField<Habitacion>(
                value: habitaciones.where((element) => element.habitacionDisponible).first,
                decoration: InputDecoration(
                    labelText: "Habitaciones disponibles"
                ),
                onChanged: (newVal){
                  onChangeHabitacion(newVal);
                },
                items: habitaciones.where((element) => element.habitacionDisponible).map<DropdownMenuItem<Habitacion>>((habitacion){
                    return DropdownMenuItem(
                      value: habitacion,
                      child: Text(habitacion.descripcion),
                    );
                }).toList(),
              ),
            )
          ],
        )
      ],
    );
  }

}