import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget{
  InicioPage({Key key,this.title}) : super(key: key);
  
  final title;
  
  @override
  State<StatefulWidget> createState() {
    return new _InicioPageState();
  }
}

class _InicioPageState extends State<InicioPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Inicio")
          ],
        ),
      ),
    );
  }
  
}