
import 'package:clinica_frontend/Views/Pacientes/pacientes.dart';
import 'package:flutter/material.dart';

import 'habitaciones.dart';
import 'inicio.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class DrawerItem{
  String _text;
  Widget _widget;

  DrawerItem(this._text, this._widget);

  String get text => _text;

  set text(String value) {
    _text = value;
  }

  Widget get widget => _widget;

  set widget(Widget value) {
    _widget = value;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _key=new GlobalKey();
  List<DrawerItem> _drawerItems=[
    new DrawerItem("Inicio", new InicioPage(title: "Inicio",)),
    new DrawerItem("Habitaciones", new HabitacionesPage(title: "Habitaciones",)),
    new DrawerItem("Pacientes", new PacientesPage(title: "Pacientes",))
  ];

  DrawerItem _selectedView;

  @override
  void initState(){
    _selectedView=_drawerItems.elementAt(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView.builder(
          itemBuilder: (context,index){
            return ListTile(
              title: Text(_drawerItems.elementAt(index).text),
              onTap: (){
                setState(() {
                  _selectedView=_drawerItems.elementAt(index);
                });

                Navigator.pop(context);
              },
            );
          },
          itemCount: _drawerItems.length,
        ),
      ),
      body: _selectedView.widget,// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
