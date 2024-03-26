import 'package:flutter/material.dart';
import 'package:vault/ui/home/home_generator.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({super.key});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('產生器'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(result),
            child: Text('儲存', style: TextStyle(color: Colors.white)),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: HomeGenerator(
        onGenerate: (value) => result = value,
      ),
    );
  }
}
