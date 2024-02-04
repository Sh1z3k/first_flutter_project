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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test apki'),
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
  double _suma = 0;
  double _procent = 20;
  int _liczbaOsob = 1;
  double _napiwek = 0;

  void _obliczNapiwek() {
    _napiwek = _suma * (_procent / 100.0);
    _suma += _napiwek;
    _napiwek /= _liczbaOsob;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator napiwku'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Kwota',
              ),
              onChanged: (value) {
                setState(() {
                  _suma = double.parse(value);
                  _obliczNapiwek();
                });
              },
            ),
            Slider(
              value: _procent,
              min: 0,
              max: 100,
              divisions: 100,
              label: '${_procent.toStringAsFixed(0)}%',
              onChanged: (value) {
                setState(() {

                });
              },
            ),
            Text(
              'Napiwek:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '${_napiwek.toStringAsFixed(2)} zł',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _liczbaOsob++;
                    });
                  },
                ),
                Text(
                  '${_liczbaOsob}',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      _liczbaOsob--;
                    });
                  },
                ),
              ],
            ),
            Text(
              'Tyle płaci każda osoba:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '${_suma / _liczbaOsob.toDouble()} zł',
              style: TextStyle(fontSize: 20, color: Colors.green),

            ),
          ],
        ),
      ),
    );
  }
}