import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final _nombreController = TextEditingController();
  final _celularController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _registerUser() async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: "${_celularController.text}@gmail.com",
        password: _passwordController.text,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'nombre': _nombreController.text,
        'celular': _celularController.text,
        'email': userCredential.user?.email,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cuenta registrada exitosamente")),
      );

      Navigator.pop(context); // Volver al login después del registro
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al registrar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _celularController,
              decoration: const InputDecoration(labelText: 'Celular'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña (6 números)'),
              obscureText: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text('Registrar cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
