import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Item {
  final String id;
  final String title;
  final String description;
  final PlaceLocation location;
  final File image;
  final File secondimage;

  Item({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.location,
    @required this.image,
    @required this.secondimage,
  });
}
