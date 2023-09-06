

import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationService {
  late Location location;
  bool serviceEnabled = false;
  PermissionStatus? grantPermission;


  LocationService(){
    location = Location();
  }

  Future<bool> checkPermission() async {
    if (await checkService()) {
      grantPermission = await location.hasPermission();
      if (grantPermission == PermissionStatus.denied) {
        grantPermission = await location.requestPermission();
      }
    }
    return grantPermission == PermissionStatus.granted;
  }

  Future<bool> checkService() async {
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }
    } on PlatformException catch (e) {
      print("error code ${e.code} and error message ${e.message}");
      serviceEnabled = false;
      await checkService();
    }
    return serviceEnabled;
  }

  Future<LocationData?> getLocation() async {

    if (await checkPermission()) {

      final locationData =  location.getLocation();
      return locationData;
    }
    return null;
  }
}
