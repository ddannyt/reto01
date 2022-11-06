import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// se creal la clase el constructor
class teclado{
  final titulo;
  final color;
  final icono;

  teclado(this.titulo, this.color, this.icono);
}

//Declaracion de variables y lista para el drownbutton
String op1 = "USD";
String op2 = "COP";

List<DropdownMenuItem<String>> listaMoneda = <DropdownMenuItem<String>>[
  DropdownMenuItem(value: "USD",child: Text("USD")),
  DropdownMenuItem(value: "EUR",child: Text("EUR")),
  DropdownMenuItem(value: "COP",child: Text("COP")),
];

final textOrigen = TextEditingController();
final textDestino =TextEditingController();
//lista de objetos
List<teclado> tcl = <teclado>[
  teclado("9", Colors.blueAccent, Icon(Icons.abc)),
  teclado("8", Colors.blueAccent, Icon(Icons.abc)),
  teclado("7", Colors.blueAccent, Icon(Icons.abc)),
  teclado("6", Colors.blueAccent, Icon(Icons.abc)),
  teclado("5", Colors.blueAccent, Icon(Icons.abc)),
  teclado("4", Colors.blueAccent, Icon(Icons.abc)),
  teclado("3", Colors.blueAccent, Icon(Icons.abc)),
  teclado("2", Colors.blueAccent, Icon(Icons.abc)),
  teclado("1", Colors.blueAccent, Icon(Icons.abc)),
  teclado("0", Colors.blueAccent, Icon(Icons.abc)),
  teclado("AC", Colors.blueAccent, Icon(Icons.clear_all)),
  teclado("=", Colors.blueAccent, Icon(Icons.abc)),
];
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: [
                Text("Moneda Origen : "),
                DropdownButton(
                  value: op1,
                  items: listaMoneda, 
                  onChanged: (String? x){
                    setState(() {
                      op1 = x.toString();
                    });
                  }),

                Text("Moneda Destino : "),
                DropdownButton(
                  value: op2,
                  items: listaMoneda, 
                  onChanged: (String? x){
                    setState(() {
                      op2 = x.toString();
                    });
                  }),
              ],

            ),
            TextField(

              controller: textOrigen,//el text origen representa el textfield
              decoration: InputDecoration(
                labelText: "origen",
                hintText: "0",
                icon: Icon(Icons.monetization_on)
            ),),
            TextField(
              controller: textDestino,
              decoration: InputDecoration(
                labelText: "origen",
                hintText: "0",
                icon: Icon(Icons.monetization_on)
            ),),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: tcl.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: tcl[index].color,
                    child: ListTile(
                      title: Center(
                        child: index == 10
                      ? tcl[index].icono
                      : Text(
                        tcl[index].titulo,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 35
                        ),
                      ),
                      ),
                      //ontap para crear la interacción 
                      onTap:(){
                        if(index < 10){
                          textOrigen.text = textOrigen.text + tcl[index].titulo;
                        }else if(index == 10){
                          textOrigen.clear();
                        }else {
                          if (op1 == "USD" && op2 == "COP"){
                            textDestino.text = (double.parse(textOrigen.text) * 5100)
                            .toString();
                          }else if (op1 == "USD" && op2 == "EUR"){
                            textDestino.text = (double.parse(textOrigen.text) / 5100)
                            .toString();
                          }else if (op1 == "EUR" && op2 == "USD"){
                            textDestino.text = (double.parse(textOrigen.text) * 5100)
                            .toString();
                          }else if (op1 == "EUR" && op2 == "COP"){
                            textDestino.text = (double.parse(textOrigen.text) / 5100)
                            .toString();
                          }else if (op1 == "COP" && op2 == "USD"){
                            textDestino.text = (double.parse(textOrigen.text) * 5100)
                            .toString();
                          }else if (op1 == "COP" && op2 == "EUR"){
                            textDestino.text = (double.parse(textOrigen.text) / 5100)
                            .toString();
                          }else{
                            textDestino.text = textOrigen.text;
                          }
                        }
                        
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
