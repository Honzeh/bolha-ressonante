import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';

void main() => runApp(const BolhaApp());

class BolhaApp extends StatelessWidget {
  const BolhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NoiseMeter? meter;
  StreamSubscription? sub;
  double db = 0;
  bool active = false;

  @override
  void initState() {
    super.initState();
    meter = NoiseMeter();
  }

  void start() {
    sub = meter!.noise.listen((event) {
      setState(() => db = event.meanDecibel);
    });
  }

  void stop() {
    sub?.cancel();
  }

  String getStatus() {
    if (db > 75) return "Ambiente agressivo";
    if (db > 50) return "Ambiente moderado";
    return "Ambiente calmo";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bolha Ressonante")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Intensidade: ${db.toStringAsFixed(1)} dB"),
            Text(getStatus()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                active ? stop() : start();
                setState(() => active = !active);
              },
              child: Text(active ? "Desativar" : "Ativar"),
            )
          ],
        ),
      ),
    );
  }
}
