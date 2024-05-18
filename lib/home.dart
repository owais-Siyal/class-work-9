import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _currentBatteryLevel = 'Unknown battery level.';

  Future<void> _fetchBatteryLevel() async {
    int? batteryLevel;
    try {
      batteryLevel = await platform.invokeMethod<int>('getBatteryLevel');
      _currentBatteryLevel = 'Battery level at $batteryLevel%.';
    } on PlatformException catch (e) {
      _currentBatteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Battery Status',
              style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _fetchBatteryLevel,
                child: Text('Check Battery Level'),
              ),
              SizedBox(height: 20),
              Text(_currentBatteryLevel),
            ],
          ),
        ),
      ),
    );
  }
}
