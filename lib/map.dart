import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Set<Circle> circles = <Circle>{};
    circles.add(
      const Circle(
        circleId: CircleId("Circle1"),
        center: LatLng(-6.227926, 106.600757),
        radius: 20,
      ),
    );

    LatLng titikAwal = const LatLng(-6.3, 101.1);

    Set<Marker> titiks = <Marker>{};
    titiks.add(
      const Marker(
        markerId: MarkerId("Marker1"),
        position: LatLng(-6.2, 101.2),
        infoWindow: InfoWindow(title: "Mall Taman Anggrek"),
      ),
    );
    titiks.add(
      Marker(
        markerId: const MarkerId("Marker2"),
        position: titikAwal,
        infoWindow: const InfoWindow(title: "Mall Lippo Karawaci"),
      ),
    );

    return Scaffold(
      body: GoogleMap(
        circles: circles,
        markers: titiks,
        mapType: MapType.hybrid,
        trafficEnabled: true,
        mapToolbarEnabled: true, //muncul saat tap marker
        buildingsEnabled: true,
        zoomControlsEnabled: true,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(zoom: 15, target: titikAwal),
      ),
    );
  }
}
