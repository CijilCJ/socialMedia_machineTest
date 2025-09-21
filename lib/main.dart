import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task/view/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userBox'); 
  await Hive.openBox('postBox'); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter task',
      
      home:HomePage(),
    );
  }
}

