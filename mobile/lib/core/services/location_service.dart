import 'dart:math';

import 'package:geolocator/geolocator.dart';

import '../errors/failures.dart';

/// Geospatial value object.
class LatLng {
  const LatLng(this.latitude, this.longitude);

  final double latitude;
  final double longitude;

  /// Distance in meters (Haversine).
  double distanceMetersTo(LatLng other) {
    const double r = 6371000;
    final double dLat = _rad(other.latitude - latitude);
    final double dLng = _rad(other.longitude - longitude);
    final double sinDLat = sin(dLat / 2);
    final double sinDLng = sin(dLng / 2);
    final double a = sinDLat * sinDLat +
        cos(_rad(latitude)) * cos(_rad(other.latitude)) * sinDLng * sinDLng;
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return r * c;
  }

  static double _rad(double deg) => deg * 3.141592653589793 / 180;

  Map<String, dynamic> toJson() => {'lat': latitude, 'lng': longitude};

  factory LatLng.fromJson(Map<String, dynamic> json) =>
      LatLng((json['lat'] as num).toDouble(), (json['lng'] as num).toDouble());

  @override
  bool operator ==(Object other) =>
      other is LatLng &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);

  @override
  String toString() => '($latitude, $longitude)';
}

/// Abstractions over platform location services.
abstract class LocationService {
  /// Starts permission + location flow. Throws [PermissionDeniedFailure] if denied.
  Future<Position?> getCurrentPosition();

  /// Whether the permission has already been granted.
  Future<bool> hasPermission();

  /// Request and explain why location is needed.
  Future<bool> requestPermission();
}

class GeolocatorLocationService implements LocationService {
  @override
  Future<bool> hasPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> requestPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<Position?> getCurrentPosition() async {
    final granted = await requestPermission();
    if (!granted) {
      throw const PermissionDeniedFailure();
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    return position;
  }
}

/// Convenience: convert a [Position] to our value object.
LatLng? toLatLng(Position? position) => position == null
    ? null
    : LatLng(position.latitude, position.longitude);