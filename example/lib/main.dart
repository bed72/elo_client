import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_elo_client/flutter_elo_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _response = 'Unknown';
  final _flutterEloClientPlugin = EloClient();

  @override
  void initState() {
    super.initState();

    // https://pokeapi.co/api/v2/pokemon/lucario
    makeRequest(
      const ClientModel(path: 'https://elo7.com.br/'),
    );
  }

  Future<void> makeRequest(ClientModel params) async {
    String response;

    try {
      response = await _flutterEloClientPlugin.makeRequest(path: params.path) ??
          'Unknown platform version';
    } on PlatformException catch (exception) {
      response = exception.message!;
    }

    if (!mounted) return;

    // final lucario = jsonDecode(response) as Map<String, dynamic>;

    setState(() {
      _response = response.trim(); //lucario['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons'),
        ),
        body: Center(
          child: Text(_response),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => makeRequest(
            const ClientModel(path: 'https://elo7.com.br/categoria'),
          ),
          child: const Icon(Icons.cable),
        ),
      ),
    );
  }
}
