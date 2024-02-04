import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gasiul Kacper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(203, 255, 144,1)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Kalkulator napiwków Gasiul Kacper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _procentNapiwku=10;
  double _doZaplaty=1;
  double _napiwek=1;
  int _iloscOsob=1;

  String _sumaTekst = "";


  void _wyswietlToastLiczbaOsob(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text( "Aby dodać więcej osób wykup pakiet premium!"),
        action: SnackBarAction(label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _wyswietlToastDoZaplaty(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text( "Maksymalna kwota dla kont bez premium to 99zł"),
        action: SnackBarAction(label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void _obliczRachunekNaOsobe(){ _sumaTekst = ((_doZaplaty+_doZaplaty*(_procentNapiwku/100))/_iloscOsob).toStringAsFixed(2); }

  void _obliczNapiwek(){_napiwek=_doZaplaty*(_procentNapiwku/100);}
  void _dodajOsobeDoPodzialu() {setState(() {
    if(_iloscOsob<9)_iloscOsob++;
    _obliczRachunekNaOsobe();
    if(_iloscOsob==9){;
    _wyswietlToastLiczbaOsob(context);
    }

  });
  }
  void _usunOsobeDoPodzialu() {setState(() {if(_iloscOsob>1) {_iloscOsob--;_obliczRachunekNaOsobe();}});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          //     crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(203, 255, 144,1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(children: [
                  Column(
                    children: [
                      Container(
                          child: Row(
                              children: [
                                Container(

                                  child: Text("Tyle płaci każda osoba:", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontSize: 20)),
                                  width: 350,
                                  alignment: Alignment.center,
                                )
                              ]
                          )
                      ),
                      Container(
                        child: Text("${_sumaTekst} zł", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold, fontSize: 40)),
                        width: 350,
                        alignment: Alignment.center,
                      )
                    ],
                  )
                ],)
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all( style: BorderStyle.solid, color: Color.fromRGBO(117, 117, 117, 1))
              ),
              child: Column(children: [

                TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Color.fromRGBO(69, 171, 77, 1),
                  decoration: InputDecoration(
                    hintText: 'Kwota rachunku / do zapłaty',

                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    FilteringTextInputFormatter.digitsOnly,
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9.]+$')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _doZaplaty = double.parse(value);
                      if(_doZaplaty<99){
                      _obliczRachunekNaOsobe();
                      _obliczNapiwek();
                      }
                      else{
                        _wyswietlToastDoZaplaty(context);
                      }
                    });
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                      children: [
                        Text('Liczba osób: '),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton.small(
                                onPressed: (_usunOsobeDoPodzialu),
                                tooltip: 'Decrement',
                                foregroundColor: const Color.fromRGBO(69, 171, 77, 1),
                                backgroundColor: const Color.fromRGBO(203, 255, 144,1),
                                child: const Icon(Icons.remove),
                              ),
                              SizedBox(width: 10),
                              Text(
                                  '$_iloscOsob',
                                  style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold, fontSize: 25)
                              ),
                              SizedBox(width: 10),
                              FloatingActionButton.small(
                                onPressed: _dodajOsobeDoPodzialu,
                                tooltip: 'Increment',
                                foregroundColor: const Color.fromRGBO(69, 171, 77, 1),
                                backgroundColor: const Color.fromRGBO(203, 255, 144,1),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        )
                      ]),

                ),Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Row(
                      children: [
                        Text('Cały napiwek:'),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text
                                ("${_napiwek.toStringAsFixed(2)} zł", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold, fontSize: 25)
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
                Text("${_procentNapiwku.toStringAsFixed(0)} %", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold)),
                Slider(
                  min: 0,
                  max: 100,
                  activeColor: Colors.green,
                  inactiveColor: Colors.lightGreenAccent,
                  divisions: 10,
                  value: _procentNapiwku,
                  onChanged: (double value) {
                    setState(() {
                      _procentNapiwku = value;
                      _obliczRachunekNaOsobe();
                      _obliczNapiwek();
                    });
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
