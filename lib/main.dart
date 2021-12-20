import 'dart:convert';

import 'package:djangoapp/create.dart';
import 'package:djangoapp/nota.dart';
import 'package:djangoapp/update.dart';
import 'package:djangoapp/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NotasDjango',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Nota> notas = [];

  @override
  void initState() {
    _retrieveNotas();
    super.initState();
  }

  _retrieveNotas() async {
    notas = [];

    List response =
        json.decode((await client.get(Uri.parse(retrieveUrl))).body);
    response.forEach((element) {
      notas.add(Nota.fromMap(element));
    });
    setState(() {});
  }

  void _deleteNota(int id) {
    http.delete(Uri.parse(retrieveUrl + '$id' + '/deletar/'));
    _retrieveNotas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveNotas();
        },
        child: ListView.builder(
          itemCount: notas.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(notas[index]
                  .nota
                  .replaceAll('Ã§', 'ç')
                  .replaceAll('Ã©', 'é')
                  .replaceAll('Ã£', 'ã')),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdatePage(
                        client: client,
                        id: notas[index].id,
                        nota: notas[index].nota),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteNota(notas[index].id),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CreatePage(
                  client: client,
                ))),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
