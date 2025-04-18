import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/icons_constants.dart';
import '../initialize_app_utils.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maps_toolkit;

final class GoogleMapsPolygonUtils {
  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  final Set<Polygon> _polygon = HashSet<Polygon>();
  Set<Polygon> get polygon => _polygon;
  List<LatLng> _polygonPoints = [];
  List<LatLng> get polygonPoints => _polygonPoints;

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  Future<void> onMapCreated(
      {required GoogleMapController mapController,
      required Position currentLocation,
      required void Function() onDragEnd}) async {
    _mapController = mapController;
    _polygonPoints = createPolygonAroundLocation(currentLocation);
    _polygon.add(Polygon(
      polygonId: const PolygonId('1'),
      points: _polygonPoints,
      fillColor: Colors.blue.withOpacity(0.3),
      strokeWidth: 2,
    ));
    _createMarkers(currentLocation, onDragEnd: onDragEnd);
    await mapController.animateCamera(
      CameraUpdate.newLatLng(
          LatLng(currentLocation.latitude, currentLocation.longitude)),
    );
  }

  List<LatLng> createPolygonAroundLocation(Position locationData) {
    double lat = locationData.latitude;
    double lng = locationData.longitude;

    // Modify these values to create the desired polygon around the user's location
    double offset = 0.001;
    List<LatLng> points = [
      LatLng(lat - offset, lng - offset),
      LatLng(lat - offset, lng + offset),
      LatLng(lat, lng + offset + offset),
      LatLng(lat + offset, lng + offset),
      LatLng(lat + offset, lng),
      LatLng(lat + offset, lng - offset),
    ];

    return points;
  }

  bool _isUserInsidePolygon(Position userLocation) {
    List<maps_toolkit.LatLng> points = _polygonPoints.map((latLng) {
      return maps_toolkit.LatLng(latLng.latitude, latLng.longitude);
    }).toList();

    return maps_toolkit.PolygonUtil.containsLocation(
        maps_toolkit.LatLng(userLocation.latitude, userLocation.longitude),
        points,
        false);
  }

  void _createMarkers(Position userLocation,
      {required void Function() onDragEnd}) async {
    _markers.clear();
    final canteenIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), IconsConstants.canteenGoogleMapsMarker);
    _markers.add(Marker(
        markerId: const MarkerId('canteen_location'),
        position: LatLng(userLocation.latitude, userLocation.longitude),
        icon: canteenIcon));
    final markerBoundaryIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        IconsConstants.markerBoundaryGoogleMapsMarker);
    for (int i = 0; i < _polygonPoints.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId('marker$i'),
        position: _polygonPoints[i],
        draggable: true,
        icon: markerBoundaryIcon,
        onDragEnd: (newPosition) {
          _updatePolygon(newPosition, i, onDragEnd: onDragEnd);
        },
      ));
    }
  }

  void _updatePolygon(LatLng newPosition, int markerIndex,
      {required void Function() onDragEnd}) {
    _polygonPoints[markerIndex] = newPosition;
    onDragEnd();
  }

  void get dispose {
    mapController?.dispose();
  }
}
