import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: RegistroPage(),
  ));
}

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final TextEditingController _txtNameCtrl = TextEditingController();
  final TextEditingController _txtMatriculaCtrl = TextEditingController();

  String nombre = "";
  String matricula = "";

  List<String> registros = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _txtNameCtrl,
              decoration: InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: _txtMatriculaCtrl,
              decoration: InputDecoration(
                labelText: "Matrícula",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  nombre = _txtNameCtrl.text.trim();
                  matricula = _txtMatriculaCtrl.text.trim();

                  if (nombre.isNotEmpty && matricula.isNotEmpty) {
                    registros.add('$nombre - $matricula');
                    _txtNameCtrl.clear();
                    _txtMatriculaCtrl.clear();
                  }
                });
              },
              child: Text('Agregar'),
            ),

            SizedBox(height: 20),
            Text('Registros:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...registros.map((registro) => Text(registro)).toList(),
          ],
        ),
      ),
    );
  }
}