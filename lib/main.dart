import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_poc/models/contact.dart';
import 'package:hive_poc/pages/contact_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  ///
  ///Pour utiliser Hive, il a besoin d'être initialiser avant le rendu de tout widget,
  ///et la place idéal pour le faire est dans le main comme pour firebase ou autre
  ///de ce type
  ///!L'initialisation de hive demande un paramètre qui n'est autre que le dossier
  ///!dans lequel il va stocker les donées en local. C'est là que path_provider
  ///!entre en jeu pour évider à ce qu'on ne fasse ne dure code et surtout les
  ///!droits d'accès (si on récupère le dossier dans lequel l'app est installé on est
  ///! sûr d'avoir le droit dessus)
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive POC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Hive.openBox("contacts"),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const ContactPage();
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box("contacts").close(); //Pour fermer le table ouverte
    // Hive.close(); //Pour fermer toutes les tables
    super.dispose();
  }
}
