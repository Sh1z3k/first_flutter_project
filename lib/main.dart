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






  /*
   ######################################     C Z Ę Ś Ć      L O G I C Z N A      #############################################
   */

  //deklaracja zmiennych

  // Procent wybrany na sliderze potrzebny do obliczenia napiwku. Wybierany przez użytkownika.
  double _procentNapiwku=10;

  // Kwota jaka widnieje na rachunku, bez napiwku,
  double _doZaplaty=1;

  // Napiwek - _procentNapiwku * _doZapłaty       - napiwek dodawany do całości kwoty
  double _napiwek=1;

  // Liczba osób na które ma zostać rozdzielony rachunek wraz z doliczonym napiwkiem
  int _iloscOsob=1;


  // Kwota jaką musi opłacić każda z osób, by całość rachunku + napiwek został opłacony - Na początku był to typ double, ale stwierdziłem, że skoro nie przetwarzam tej kwoty w przyszłości to zamienię ją na String.
  String _sumaTekst = "";



  // Toast wyświetlający informację o potrzebie zakupu premium, by dodać więcej niż 9 osób do podziału rachunku
  void _wyswietlToastLiczbaOsob(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text( "Aby dodać więcej osób wykup pakiet premium!"),
        action: SnackBarAction(label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  // Toast wyświetlający informację o potrzebie zakupu premium, by odblokować rozliczanie kwot większych niż 99zł
  void _wyswietlToastDoZaplaty(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text( "Maksymalna kwota dla kont bez premium to 99zł"),
        action: SnackBarAction(label: 'Zamknij', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


// Funkcja dodająca osobę do podziału rachunku + napiwku. Wykorzystywana przy kliknięciu przycisku "+" w rzędzie z tekstem "Liczba osób:"
// Dodatkowa funkcja: ograniczenie maksymalnej ilości osób do 9, żeby dodać więcej osób należy wykupić w przyszłości zaimplementowaną funkcję premium.
  void _dodajOsobeDoPodzialu() {setState(() {
    if(_iloscOsob<9)_iloscOsob++;
    _obliczRachunekNaOsobe();
    if(_iloscOsob==9){;
    _wyswietlToastLiczbaOsob(context);
    }
  });
  }

  // Funkcja usuwająca osobę do podziału. Aktywowana, gdy zostanie naciśnięty przycisk "-" w rzędzie "Liczba osób:".
  void _usunOsobeDoPodzialu() {setState(() {if(_iloscOsob>1) {_iloscOsob--;_obliczRachunekNaOsobe();}});
  }

  // Obliczanie samego napiwku na podstawie podanej kwoty rachunku, która jest pomnożona przez procent napiwku wybrany przez użytkownika
  void _obliczNapiwek(){_napiwek=_doZaplaty*(_procentNapiwku/100);}

  // Główna funkcja odpowiadająca za najważniejszą część logiczną aplikacji. Obliczanie kwoty, którą musi uiścić każda osoba dodana do podziału.
  // Obliczanie na podstawie Kwoty Rachunku z dodanym napiwkiem. Całość jest dzielona na ilość osób biorących udział w podziale.
  void _obliczRachunekNaOsobe(){ _sumaTekst = ((_doZaplaty+_doZaplaty*(_procentNapiwku/100))/_iloscOsob).toStringAsFixed(2); }











/*
######################################     C Z Ę Ś Ć      W I Z U A L N A      #############################################

Sekcja odpowiedzialna za wyświetlanie poszczególnych przycisków, Slider'ów, tekstów, pól w taki sposób, by aplikacja była łatwa w użytkowaniu.
Kolorystyka również została dopasowana w taki sposób, by była aplikacja była przyjemniejsza w użytkowaniu.

Jedyny problem, który napotkałem i nie mogłem sobie z nim poradzić to wyświetlanie w jednym rzędzie (Row) kilku pól, gdzie jednym z nich było pole TextField.
W momencie dodawania chociażby pola Text w jednym rzędzie z polem TextField aplikacja przestawała wyświetlać zdecydowaną większość elementów - dlatego oddaję projekt bez znaku niebieskiego dolara ("$") obok pola TextField.

 */

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(

        // Kolumna rozdzielająca aplikację na część górną (zieloną) i część dolną (z suwakiem i wyborem liczby osób)
        child: Column(
          children: <Widget>[

            // Kontener odpowiedzialny za estetyczne wyświetlanie górnej części aplikacji i jej tła w kolorze jasnej, pastelowej zieleni z zaokrąglonymi rogami
            Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(203, 255, 144,1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(children: [

                  // Kolumna odpowiadająca za rozdzielenie tekstu "Tyle płaci każda osoba:" z kwotą, którą każda osoba ma zapłacić
                  Column(
                    children: [

                      // Kontener wyświetlający estetyczny tekst "Tyle płaci każda osoba:" z odpowiednim formatowaniem tekstu
                      Container(
                          child: Container(
                                  child: Text("Tyle płaci każda osoba:", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontSize: 20)),
                                  width: 350,
                                  alignment: Alignment.center,
                                )

                      ),

                      // Kontener wyświetlający sumę jaką każda osoba ma uiścić. Również odpowiada za estetyczne wyświetlanie tekstu o odpowiedniej czcionce i kolorze.
                      Container(
                        child: Text("${_sumaTekst} zł", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold, fontSize: 40)),
                        width: 350,
                        alignment: Alignment.center,
                      )
                    ],
                  )
                ],)
            ),

            // Kontener wyświetlający dolną część aplikacji zawierającą pole do edycji kwoty rachunku, edycji liczby osób, informacji o aktualnym napiwku i edycji napiwku.
            // Zaimplementowano element estetyczny taki jak widoczne obramowanie z zaokrągleniem.
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all( style: BorderStyle.solid, color: Color.fromRGBO(117, 117, 117, 1))
              ),
              /*
              Kolumna rozdzielająca wszystkie sekcje aplikacji, zastosowano podział na:
              - sekcję wyświetlania i edycji Kwoty Rachunku
              - sekcję wyświetlania i edycji Liczby Osób
              - sekcję wyświetlania aktualnie wybranej wartości napiwku
              - sekcję wyboru procentu kwoty, która zostanie dodana do rachunku jako napiwek wraz z informacją o ilości wybranego procentu
              */
              child: Column(children: [

                // Pole tesktowe, w którym użytkownik powinien wpisać kwotę rachunku, która będzie później przetwarzana. Ograniczenie do 99zł dla użytkowników bez premium
                TextField(
                  keyboardType: TextInputType.number,
                  cursorColor: Color.fromRGBO(69, 171, 77, 1),
                  decoration: InputDecoration(
                    hintText: 'Kwota rachunku / do zapłaty',

                  ),

                  // Informacje dotyczące ograniczeń pola tesktowego
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                    // FilteringTextInputFormatter.digitsOnly, - ta opcja powoduje brak możliwości wpisywania kropki, więc zdecydowałem się zastosować inne ograniczenie wpisywanego tekstu

                    // Minusem podejścia z wykorzystaniem tekiego formatowania jest resetowanie się kwoty w polu tekstowym w momencie wpisywania tekstu, jednak aplikacja na telefonie nie pozwala na wybranie klawiwatury z tekstem.
                    // jedynie klawisz przecinka "," powoduje, że tekst nie jest zczytywany poprawnie, ale da się to naprawić zczytując wartość wpisaną przez użytkownika jako String i następnie konwertując ją na double w 2 różne sposoby w zależności od tego czy jest przecinek czy kropka
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9.,]+$')),
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

                // Kontener odpowiadający za rząd Liczby osbób, w skrócie: wyświetlanie tekstu, 2 przyciski i tekst z aktualnie wybraną ilością osób
                // Nie będę ukrywać, że napotkałem trochę problemów z wyrównaniem jednej strony rzędu do lewej, a drugiej do prawej, ale finalnie efekt jest moim zdaniem zadowalający
                Container(
                  child: Row(
                      children: [
                        Text('Liczba osób: '),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Zastosowanie przycisku FloatingActionButton w wersji small, gdyż bardziej estetycznie wpasowuje się w aplikację niż jego domyślna wersja
                              // zastosowano przypisanie funkcji na reakcję kliknięcia przycisku, która zmniejsza ilośc osób
                              // dodatkowo zadbano o aspekty wizualne
                              FloatingActionButton.small(
                                onPressed: (_usunOsobeDoPodzialu),
                                tooltip: 'Decrement',
                                foregroundColor: const Color.fromRGBO(69, 171, 77, 1),
                                backgroundColor: const Color.fromRGBO(203, 255, 144,1),
                                child: const Icon(Icons.remove),
                              ),

                              SizedBox(width: 10),

                              // Tekst pomiędzy przyciskami wyświetlający aktualnie wybraną ilość osób. Tekst wizualnie spójny z całością aplikacji
                              Text(
                                  '$_iloscOsob',
                                  style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold, fontSize: 25)
                              ),

                              SizedBox(width: 10),

                              // Przycisk odpowiedzialny za zwiększenie ilości osób do podziału rachunku z napiwkiem. Również zadbano o aspekty wizualne
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

                  // Kontener wyświetlający wartość aktualnie wybranego napiwku z zachowaniem spójności wizualnej z resztą aplikacji
                ),Container(
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

                // Tekst wyświetlający wartość procentową, która aktualnie została wybrana na Sliderze znajdującym się poniżej
                Text("${_procentNapiwku.toStringAsFixed(0)} %", style: TextStyle(color: Color.fromRGBO(69, 171, 77, 1), fontWeight: FontWeight.bold)),

               // Slider którym użytkownik może edytować aktualnie wybrany procent napiwku
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
