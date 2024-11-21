import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Porcentaje de Hombres y Mujeres',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const GenderPercentageCalculator(),
    );
  }
}

class GenderPercentageCalculator extends StatefulWidget {
  const GenderPercentageCalculator({super.key});

  @override
  State<GenderPercentageCalculator> createState() =>
      _GenderPercentageCalculatorState();
}

class _GenderPercentageCalculatorState
    extends State<GenderPercentageCalculator> {
  final TextEditingController _menController = TextEditingController();
  final TextEditingController _womenController = TextEditingController();

  double? menPercentage;
  double? womenPercentage;
  String? errorMessage;

  void calculatePercentages() {
    final int? men = int.tryParse(_menController.text);
    final int? women = int.tryParse(_womenController.text);

    if (men == null || women == null) {
      setState(() {
        errorMessage = "Por favor, ingresa números válidos.";
        menPercentage = null;
        womenPercentage = null;
      });
      return;
    }

    if (men < 0 || women < 0) {
      setState(() {
        errorMessage = "Los valores no pueden ser negativos.";
        menPercentage = null;
        womenPercentage = null;
      });
      return;
    }

    final int total = men + women;

    if (total > 0) {
      setState(() {
        errorMessage = null;
        menPercentage = (men / total) * 100;
        womenPercentage = (women / total) * 100;
      });
    } else {
      setState(() {
        errorMessage = "El total no puede ser cero.";
        menPercentage = null;
        womenPercentage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Porcentaje de Géneros'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _menController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de Hombres',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.teal.shade50,
                errorText: errorMessage,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _womenController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de Mujeres',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.teal.shade50,
                errorText: errorMessage,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculatePercentages,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Calcular Porcentajes',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            if (menPercentage != null && womenPercentage != null)
              Card(
                color: Colors.teal.shade100,
                elevation: 4,
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Porcentaje de Hombres: ${menPercentage!.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Porcentaje de Mujeres: ${womenPercentage!.toStringAsFixed(2)}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
