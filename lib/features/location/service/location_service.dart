import 'dart:async';

import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  bool _isListening = false;

  Future<LocationData?> getCurrentLocation() async {
    try {
      if (await checkAndRequestLocationService() &&
          await checkAndRequestLocationPermission()) {
        return await _location.getLocation();
      }
      return null;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  Future<bool> checkAndRequestLocationService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    return serviceEnabled;
  }

  Future<bool> checkAndRequestLocationPermission() async {
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.deniedForever) return false;

    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }

    return permission == PermissionStatus.granted;
  }


  void getLocationData(void Function(LocationData)? onData) async {
    _location.onLocationChanged.listen(onData);
  }
   void pauseLocationStream() {
    _locationSubscription?.pause();
    _isListening = false;
  }

  void resumeLocationStream() {
    if (_locationSubscription != null && !_isListening) {
      _locationSubscription?.resume();
      _isListening = true;
    }
  }

  void listenToLocation(void Function(LocationData) onData) {
    _locationSubscription?.cancel();
    _isListening = true;
    _locationSubscription = _location.onLocationChanged.listen(onData);
  }

  void dispose() {
    _locationSubscription?.cancel();
    
  }
}
