import 'package:flutter/material.dart';
import 'package:flutter_firebase_study/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // 앱 초기화가 완료된 후 실행
  await Hive.initFlutter();
  await Hive.openBox("caravanCustomer");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}
