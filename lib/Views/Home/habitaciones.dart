import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HabitacionesPage extends StatefulWidget{
  HabitacionesPage({Key key,this.title}): super(key:key);

  final title;

  @override
  State<StatefulWidget> createState() {
    return new HabitacionesPageState();
  }
}

class HabitacionesPageState extends State<HabitacionesPage>{
  List<int> hola=[1,2,3,4,5,6];

  List<Widget> returnItems(){
    List<Widget> items=[];

    for(int item in hola){
      items.add(
        Card(
          child: Text(item.toString()),
        )
      )  ;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: returnItems(),
      ),
    );
  }

}