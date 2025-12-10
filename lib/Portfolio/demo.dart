// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//
// class ShopMapScreen extends StatefulWidget {
//   @override
//   _ShopMapScreenState createState() => _ShopMapScreenState();
// }
//
// class _ShopMapScreenState extends State<ShopMapScreen> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   final LatLng shopLocation = LatLng(28.6139, 77.2090);
//
//   Location location = Location();
//   LatLng? userLocation;
//
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints(apiKey: 'https://www.google.com/maps/place/India+Gate/@28.6129,77.2295,17z');
//
//   final String googleApiKey = "https://www.google.com/maps/place/India+Gate/@28.6129,77.2295,17z";
//
//   @override
//   void initState() {
//     super.initState();
//     getUserLocation();
//   }
//
//   Future<void> getUserLocation() async {
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) return;
//     }
//
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) return;
//     }
//
//     LocationData locData = await location.getLocation();
//     userLocation = LatLng(locData.latitude!, locData.longitude!);
//
//     getRoute(); // 🚀 Get route once user location is ready
//
//     setState(() {});
//   }
//
//   // Get route (polyline) from Google Directions API
//   Future<void> getRoute() async {
//     PolylineRequest request = PolylineRequest(
//       origin: PointLatLng(userLocation!.latitude, userLocation!.longitude),
//       destination: PointLatLng(shopLocation.latitude, shopLocation.longitude),
//       mode: TravelMode.driving,  // optional: specify travel mode
//     );
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       request: request,
//     );
//
//     if (result.points.isNotEmpty) {
//       polylineCoordinates.clear();
//       result.points.forEach((p) {
//         polylineCoordinates.add(LatLng(p.latitude, p.longitude));
//       });
//
//       setState(() {});
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Shop Navigation")),
//       body: userLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: userLocation!,
//           zoom: 14,
//         ),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         markers: {
//           Marker(markerId: MarkerId("shop"), position: shopLocation),
//           Marker(markerId: MarkerId("user"), position: userLocation!)
//         },
//         polylines: {
//           Polyline(
//             polylineId: PolylineId("route"),
//             points: polylineCoordinates,
//             width: 6,
//             color: Colors.blue, // route line
//           )
//         },
//         onMapCreated: (controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }
