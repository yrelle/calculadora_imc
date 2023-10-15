import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class IMC {
  double peso;
  double altura;
  double resultado;

  IMC({
    required this.peso,
    required this.altura,
  }) : resultado = peso / (altura * altura);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final List<IMC> imcList = [];

  void _calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;
    if (peso > 0 && altura > 0) {
      setState(() {
        IMC novoIMC = IMC(peso: peso, altura: altura);
        imcList.add(novoIMC);
        pesoController.clear();
        alturaController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Por favor, insira valores válidos para peso e altura.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: pesoController,
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: alturaController,
                decoration: InputDecoration(labelText: 'Altura (m)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularIMC,
                child: Text('Calcular IMC'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: imcList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('IMC: ${imcList[index].resultado.toStringAsFixed(2)}'),
                      subtitle: Text('Peso: ${imcList[index].peso} kg, Altura: ${imcList[index].altura} m'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
