import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapPage extends StatefulWidget  {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition myHome = CameraPosition(
    target: LatLng(21.16126705305539, 81.22605545901469),
    zoom: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            colors: [
              Color(0xff09023f),
              Color(0xff5a5398),
              Color(0xffe7e6ee),
            ]
          )
        ),
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: myHome,
          markers: {
            Marker(markerId: const MarkerId("Home"), position: myHome.target)
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: _goToHome,
        label: const Text('To Anjora!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(myHome));
  }
}
