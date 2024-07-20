import 'package:flutter/material.dart';
import 'package:money_calc/source/logic.dart';
import 'package:money_calc/widgets/mainWidget.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CalcModel>(
        model: CalcModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Калькулятор ставки',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Калькулятор ставки'),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: MainWidget(),
      ),
    );
  }
}
