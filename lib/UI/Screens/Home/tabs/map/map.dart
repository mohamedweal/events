import 'package:events/UI/Screens/Home/tabs/map/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;
import 'package:location/location.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});
  Future<void> _loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map/map_style.json',
    );
  }

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  String? _style;
  late GoogleMapController _controller;
  Location location = Location();
  LatLng? initLocation;

  Future<void> _loadMapStyle() async {
    final String style = await rootBundle.loadString(
      'assets/map/map_style.json',
    );
    setState(() {
      _style = style;
    });
  }

  @override
  void initState() {
    _loadMapStyle();
    initializeMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: initLocation ?? LatLng(0, 0),
                zoom: 10,
              ),
              onMapCreated: (controller) {
                _controller = controller;
              },
              style: _style,
              markers: Event.getEgyptianEvents()
                  .map(
                    (event) => Marker(
                      onTap: () {
                        _updateCameraPosition(LatLng(event.lat, event.lng));
                      },
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueAzure,
                      ),
                      infoWindow: InfoWindow(title: event.title),
                      markerId: maps.MarkerId(event.id),
                      position: maps.LatLng(event.lat, event.lng),
                    ),
                  )
                  .toSet(),
            ),
    );
  }

  Future<void> _updateCameraPosition(LatLng latlng) async {
    await _controller.animateCamera(
      duration: Duration(milliseconds: 500),
      CameraUpdate.newCameraPosition(CameraPosition(target: latlng, zoom: 15)),
    );
  }

  Future<void> initializeMap() async {
    // step 1 => check if location services are enabled

    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        return;
      }
    }

    // step 2 => check permission status
    PermissionStatus permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    //step 3 => get location
    var locationData = await location.getLocation();
    setState(() {
      initLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }
}
