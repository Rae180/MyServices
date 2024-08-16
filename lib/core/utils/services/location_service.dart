// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:http/http.dart' as http;

// import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

class Locationprediction {
  final String id;
  final String text;
  Locationprediction({
    required this.id,
    required this.text,
  });
}

class LocationService {
  static Future<GeoLoc?> getLocationCoords() async {
    LocationPermission status = await Geolocator.checkPermission();
    print(status);
    if (status == LocationPermission.whileInUse ||
        status == LocationPermission.always) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        // Location location =  Location();
// var position = await location.Location.instance.getLocation();
        GeoLoc geoLoc = GeoLoc(
          lng: position.longitude,
          lat: position.latitude,
        );

        print('lng ${position.longitude} lat ${position.latitude}');

        return geoLoc;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
      ].request();
    }
    return null;
  }

  // static Future<String> fetchAddress(GeoLoc loc) async {
  //   final response = await http.get(
  //     Uri.parse(
  //         'https://maps.googleapis.com/maps/api/geocode/json?latlng=${loc.lat},${loc.lng}&key=${ApiConstants.googleApisKey}'),
  //   );
  //   print('status code ${response.statusCode} ');
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseJson = json.decode(response.body);
  //     print(responseJson.toString());
  //     if (responseJson["results"] != null &&
  //         responseJson["results"].length > 0) {
  //       return responseJson["results"][0]["formatted_address"];
  //     } else {
  //       return 'UAE';
  //     }
  //   } else {
  //     return 'UAE';
  //   }
  // }
}

class GeoLoc {
  late double? lat;
  late double? lng;

  GeoLoc({required this.lat, required this.lng});

  GeoLoc.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
