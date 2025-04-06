import 'package:flutter/material.dart';
import 'login.dart';
import 'registro.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Esto es clave
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(primarySwatch: Colors.blue),
      // Estableces la pantalla inicial como Login
      home: const LoginScreen(),
      // Agregas rutas para poder navegar entre pantallas
      routes: {
        '/registro': (context) => const Registro(), // Ruta hacia la pantalla de registro
      },
    );
  }
}
