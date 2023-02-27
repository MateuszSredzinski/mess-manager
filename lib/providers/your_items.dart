import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../helpers/db_helper.dart';

class YourItems with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  Item findById(String id) {
    print('_items pusty? ${_items}');
    return _items.firstWhere((item) => item.id == id);
  }

  // findById(String id) {
  //   if (id == null) {
  //     return null;
  //   }
  //   return _items.firstWhere((element) => element.id == id);
  // }

  Future<void> addItem(
    String pickedTitle,
    String pickedDescription,
    File pickedImage,
    File pickedSecondImage,
    // PlaceLocation pickedLocation,
  ) async {
    // final address = await LocationHelper.getPlaceAddress(
    //     pickedLocation.latitude, pickedLocation.longitude);
    // final updatedLocation = PlaceLocation(
    //   latitude: pickedLocation.latitude,
    //   longitude: pickedLocation.longitude,
    //   address: address,
    // );
    final newItem = Item(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      description: pickedDescription,
      secondimage: pickedSecondImage,

      // location: updatedLocation,
    );

    _items.add(newItem);
    notifyListeners();
    DBHelper.insert('user_items', {
      'id': newItem.id,
      'title': newItem.title,
      'description': newItem.description,
      'image': newItem.image.path,
      'secondimage': newItem.secondimage.path,
    });
  }

  Future<void> fetchAndSetItems() async {
    final dataList = await DBHelper.getData('user_items');
    _items = dataList
        .map(
          (item) => Item(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            image: File(item['image']),
            secondimage: File(item['secondimage']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
