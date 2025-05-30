import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quranapp/screens/qibla/qibla_compass.dart';
// import 'package:quranapp/screens/qibla/qibla_map.dart';
import 'package:quranapp/widgets/loading_indicator_widget.dart';

class QiblaPage extends StatefulWidget {
  @override
  _QiblaPageState createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  late StreamController<LocationStatus> _locationStreamController;
  Stream<LocationStatus> get locationStream => _locationStreamController.stream;

  @override
  void initState() {
    super.initState();
    _locationStreamController = StreamController.broadcast();
    _checkLocationStatus();
  }

  @override
  void dispose() {
    _locationStreamController.close();
    FlutterQiblah().dispose();
    super.dispose();
  }

  Future<void> _checkLocationStatus() async {
    try {
      final status = await FlutterQiblah.checkLocationStatus();

      if (status.enabled && status.status == LocationPermission.denied) {
        await _requestLocationPermission();
      } else {
        _locationStreamController.add(status);
      }
    } catch (e) {
      _locationStreamController.addError('Error checking location: $e');
    }
  }

  Future<void> _requestLocationPermission() async {
    try {
      await FlutterQiblah.requestPermissions();
      final newStatus = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.add(newStatus);
    } catch (e) {
      _locationStreamController.addError('Permission request failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool?>(
        future: _deviceSupport,
        builder: (context, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error.toString()}"));

          if (snapshot.data != null && snapshot.data == true)
            // Device supports the Sensor, Display Compass widget
            return QiblahCompass();
          else
            // Device does not support the sensor, Display Maps widget
            return Center(child: Text("Your Device is Not Supported"));
        },
      ),
    );
  }
}
