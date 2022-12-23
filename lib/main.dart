import 'package:flutter/material.dart';
import 'package:flag/flag.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Phrases',
      home: PhrasesList(),
    );
  }
}

class PhrasesList extends StatefulWidget {
  const PhrasesList({Key? key}) : super(key: key);

  @override
  State<PhrasesList> createState() => _PhrasesListState();
}

class _PhrasesListState extends State<PhrasesList> {
  var _item = [];
  int _index = 0;
  int _itemsCount = 0;
  final _saved = <String>{};
  final _phraseFont = const TextStyle(fontSize: 14);

  void _refreshPage() {
    setState(() {
      if (_index == _itemsCount - 1) {
        _index = 0;
      } else {
        _index++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var phrases = [
      {
        "cz": "Dobré ráno, jak to jde?\n"
              "docela to jde.\n"
              "Díky",
        "gb": "Good Morning, how are you?\n"
              "between fifty and the  middle.\n"
              "Thanks",
        "de": "Guten Morge, wie Gehts es dir?\n"
              "Gehts gut.\n"
              "Danke",
        "fr": "Bonjour, ca va?\n"
              "Comme ci, comme ca.\n"
              "Merci",
        "es": "Buenos días, ¿cómo estás?\n"
               "entre cincuenta y medio.\n"
               "Gracias",
      },
      {
        "cz": "Mám tu rezervaci.\n"
              "Ok, na jaké jméno?\n"
              "Jmenuji se Milan a jsem z Česka.",
        "gb": "I have reservation here.\n"
              "Ok, what's your name?\n"
              "My name is Milan and I'm from Czech.",
        "de": "I habe eine Reservirun hier.\n"
              "Ok, was ist Seine name?\n"
              "Meine name ist Milan und ich gehe aus Tsechien.",
        "fr": "J'ai une reservation ici.\n"
              "Quelle votre nom?\n"
              "Je suis Milan et je vien à Tcheque.",
        "es": "Tengo reserva aquí.\n"
              "Vale, ¿cuál es tu nombre?\n"
              "Mi nombre es Milán y soy de la República Checa.",
      },
      {
        "cz": "Jste odsud?\n"
              "Ne, žiju v Praze\n"
              "To mě mrzí.",
        "gb": "Are you local?\n"
              "No, I live in Prague.\n"
              "I'm sorry.",
        "de": "Sind sie von hier?\n"
              "Nein, ich wohne in Prag.\n"
              "Tut mir leider.",
        "fr": "Vous êtes d'ici?\n"
              "Non, je habite à Prague.\n"
              "Je suis desole.",
        "es": "¿Eres de aquí?\n"
               "No, vivo en Praga.\n"
               "Lo siento.",
      },
    ];

    List<String> phraseItems = <String>[];
    for (var val in phrases[_index].values) {
      phraseItems.add(val);
    }
    List<String> countries = <String>[];
    for (var key in phrases[_index].keys) {
      countries.add(key);
    }

    _itemsCount = phrases.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phrases'),
      ),
      body: ListView.separated(
        itemCount: phrases[_index].length,
        separatorBuilder: (ctx, i) => const Divider(),
        itemBuilder: (ctx, i) {
          _item = phraseItems;
          final alreadySaved = _saved.contains(countries[i]);
          return ListTile(
            leading: Flag.fromString(
              countries[i],
              height: 45,
              width: 70,
            ),
            title: Text(
              _item[i],
              style: _phraseFont,
            ),
            // subtitle: Text(phraseItems.length.toString()),
            trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(countries[i]);
                } else {
                  _saved.add(countries[i]);
               }
              });
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshPage,
        tooltip: 'Next',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
