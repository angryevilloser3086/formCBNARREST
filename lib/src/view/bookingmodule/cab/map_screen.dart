import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/app_utils.dart';
import '../list_req/requests.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.dest});
  final LatLng dest;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> routeCoordinates = [];
  List<LatLng> polylineCoordinates = [];
  DistanceCalculator distanceCalculator = DistanceCalculator();
  static const String googleApiKey = 'AIzaSyDlYLALZZw0yXpleOSxpGzGxLw-K86F9SY';
  String totalDistance = '0.0';
  MapsRoutes route = MapsRoutes();
  static const LatLng dest = LatLng(17.448294, 78.391487);
  LatLng? source;
  PolylineResult? res;
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  Polyline? polyline;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _updateUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng userLocation = LatLng(position.latitude, position.longitude);

    //print(polyline!.points.toList());
    if (mounted) {
      setState(() {
        routeCoordinates.add(userLocation);
        mapController?.animateCamera(CameraUpdate.newLatLng(userLocation));
      });
    }
  }

  @override
  void dispose() {
    mapController!.dispose();
    
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _updateUserLocation();

    Geolocator.getPositionStream().listen((position) async {
      LatLng userLocation = LatLng(position.latitude, position.longitude);
      res = await polylinePoints.getRouteBetweenCoordinates(
          googleApiKey,
          PointLatLng(userLocation.latitude, userLocation.longitude),
          PointLatLng(widget.dest.latitude, widget.dest.longitude));
      polyline = Polyline(
          polylineId: const PolylineId("Routes"),
          color: const Color(0xff4a54cd),
          width: 4,
          points:
              res!.points.map((e) => LatLng(e.latitude, e.longitude)).toList());
      var dis = distanceCalculator.calculateRouteDistance(
          res!.points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
          decimals: 2);
     
      if (mounted) {
        setState(() {
          totalDistance = dis;

          routeCoordinates.add(userLocation);
          source = userLocation;
          mapController?.animateCamera(CameraUpdate.newLatLng(userLocation));
        });
      }
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.appSTCColor,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Journey Map",
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: (routeCoordinates.isEmpty || polyline == null)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  )
                : GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    circles: {
                      Circle(
                          circleId: const CircleId('1'),
                          center: routeCoordinates.last)
                    },
                    mapType: MapType.normal,
                    polylines: {polyline!},
                    initialCameraPosition: CameraPosition(
                      zoom: 15.0,
                      target: widget.dest,
                    ),
                    markers: {
                      Marker(
                          markerId: const MarkerId("1"), position: widget.dest)
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _onMapCreated(controller);
                      _controller.complete(controller);
                    },
                  ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          totalDistance,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),
              //if (double.parse(updateDistance()) < 0.5)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "End journey",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String updateDistance() {
    if (totalDistance != 'No route') {
      return totalDistance.substring(0, totalDistance.length - 2);
    } else {
      return "0.0";
    }
  }

}




