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
        primarySwatch: Colors.lightGreen,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Calculadora Grupo 3 NRC2292'),
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
class teclado {
  final titulo;
  final color;
  final icono;

  teclado(this.titulo, this.color, this.icono);
}

String numberFormat(double x) {
  List<String> parts = x.toString().split('.');
  RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

  parts[0] = parts[0].replaceAll(re, '.');
  if (parts.length == 1) {
    parts.add('00');
  } else {
    parts[1] = parts[1].padRight(2, '0').substring(0, 4);
  }
  return parts.join(',');
}

//Declaracion de variables y lista para el drownbutton
String op1 = "USD";
String op2 = "COP";

List<DropdownMenuItem<String>> listaMoneda = <DropdownMenuItem<String>>[
  DropdownMenuItem(value: "USD", child: Text("USD")),
  DropdownMenuItem(value: "EUR", child: Text("EUR")),
  DropdownMenuItem(value: "COP", child: Text("COP")),
];

final textOrigen = TextEditingController();
final textDestino = TextEditingController();
//lista de objetos
List<teclado> tcl = <teclado>[
  teclado("9", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("8", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("7", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("6", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("5", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("4", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("3", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("2", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("1", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado("0", Color.fromARGB(255, 23, 161, 143), Icon(Icons.abc)),
  teclado(
      "AC", Color.fromARGB(255, 249, 250, 250), Icon(Icons.cleaning_services)),
  teclado("=", Color.fromARGB(255, 254, 255, 255), Icon(Icons.calculate)),
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
                    onChanged: (String? x) {
                      setState(() {
                        op1 = x.toString();
                      });
                    }),
                Text("Moneda Destino : "),
                DropdownButton(
                    value: op2,
                    items: listaMoneda,
                    onChanged: (String? x) {
                      setState(() {
                        op2 = x.toString();
                      });
                    }),
              ],
            ),
            TextField(
              controller: textOrigen, //el text origen representa el textfield
              decoration: InputDecoration(
                  labelText: "Origen",
                  hintText: "0",
                  icon: Icon(Icons.monetization_on)),
            ),
            TextField(
              enabled: false,
              controller: textDestino,
              decoration: InputDecoration(
                  labelText: "Destino",
                  hintText: "0",
                  icon: Icon(Icons.monetization_on)),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: tcl.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape:
                        Border.all(width: 3.0, color: const Color(0xFFFFFFFF)),
                    color: tcl[index].color,
                    child: ListTile(
                      title: Center(
                        child: index == 10
                            ? tcl[index].icono
                            : Text(
                                tcl[index].titulo,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 35),
                              ),
                      ),
                      //ontap para crear la interacción
                      onTap: () {
                        if (index < 10) {
                          textOrigen.text = textOrigen.text + tcl[index].titulo;
                        } else if (index == 10) {
                          textDestino.clear();
                          textOrigen.clear();
                        } else {
                          if (op1 == "USD" && op2 == "COP") {
                            textDestino.text =
                                (double.parse(textOrigen.text) * 5000)
                                    .toString();
                          } else if (op1 == "COP" && op2 == "USD") {
                            textDestino.text =
                                (double.parse(textOrigen.text) / 5000)
                                    .toString();
                          } else if (op1 == "EUR" && op2 == "COP") {
                            textDestino.text =
                                (double.parse(textOrigen.text) * 5100)
                                    .toString();
                          } else if (op1 == "COP" && op2 == "EUR") {
                            textDestino.text =
                                (double.parse(textOrigen.text) / 5100)
                                    .toString();
                          } else if (op1 == "EUR" && op2 == "USD") {
                            textDestino.text =
                                (double.parse(textOrigen.text) * 1.1)
                                    .toString();
                          } else if (op1 == "USD" && op2 == "EUR") {
                            textDestino.text =
                                (double.parse(textOrigen.text) / 1.1)
                                    .toString();
                          } else {
                            textDestino.text = textOrigen.text;
                          }
                          if (textDestino.text != textOrigen.text) {
                            textDestino.text =
                                numberFormat(double.parse(textDestino.text));
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
