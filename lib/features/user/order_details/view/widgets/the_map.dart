import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:start/features/user/order_details/view/widgets/Markeri.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _markerPosition = LatLng(35.00000000, 38.00000000);
  void _onMarkerDragEnd(LatLng newPosition) {
    setState(() {
      _markerPosition = newPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: Stack(children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: _markerPosition,
                      initialZoom: 8,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      DragMarkers(markers: [
                        DragMarker(
                          onDragUpdate: ((details, latLng) {
                            _onMarkerDragEnd(latLng);
                          }),
                          point: _markerPosition,
                          builder: (context, pos, isDragging) => Markeri(),
                          size: const Size(30, 30),
                        )
                      ]),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: MediaQuery.of(context).size.width / 2.6,
                    child: ElevatedButton(
                        onPressed: () {
                          print(_markerPosition);
                          Navigator.of(context).pop(_markerPosition);
                        },
                        child: const Text('Done')),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
