import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.pink,
    ),
    home: CalculadoraIMC(),
  ));
}

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({Key? key}) : super(key: key);

  @override
  _CalculadoraIMCState createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  List<String> resultados = [];

  double calcularIMC() {
    final double peso = double.tryParse(pesoController.text) ?? 0;
    final double altura = double.tryParse(alturaController.text) ?? 0;

    if (peso > 0 && altura > 0) {
      final imc = peso / (altura * altura);
      String mensagem = "Resultado inválido";

      if (imc > 0) {
        if (imc < 16) {
          mensagem = "Magreza grave";
        } else if (imc < 17) {
          mensagem = "Magreza moderada";
        } else if (imc < 18.5) {
          mensagem = "Magreza leve";
        } else if (imc < 25) {
          mensagem = "Saudável";
        } else if (imc < 30) {
          mensagem = "Sobrepeso";
        } else if (imc < 35) {
          mensagem = "Obesidade grau 1";
        } else if (imc < 40) {
          mensagem = "Obesidade grau 2";
        } else {
          mensagem = "Obesidade grau 3";
        }
      }

      setState(() {
        resultados.add("IMC: ${imc.toStringAsFixed(2)} - $mensagem");
        pesoController.text = "";
        alturaController.text = "";
      });
      return imc;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: pesoController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Peso (kg)"),
            ),
            TextField(
              controller: alturaController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Altura (m)"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final imc = calcularIMC();
                String mensagem = "Resultado inválido";
                if (imc > 0) {
                  if (imc < 16) {
                    mensagem = "Magreza grave";
                  } else if (imc < 17) {
                    mensagem = "Magreza moderada";
                  } else if (imc < 18.5) {
                    mensagem = "Magreza leve";
                  } else if (imc < 25) {
                    mensagem = "Saudável";
                  } else if (imc < 30) {
                    mensagem = "Sobrepeso";
                  } else if (imc < 35) {
                    mensagem = "Obesidade grau 1";
                  } else if (imc < 40) {
                    mensagem = "Obesidade grau 2";
                  } else {
                    mensagem = "Obesidade grau 3";
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("IMC: ${imc.toStringAsFixed(2)} - $mensagem"),
                  ),
                );
              },
              child: const Text("Calcular IMC"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: resultados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(resultados[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
