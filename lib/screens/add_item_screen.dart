import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

import '../providers/your_items.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = '/add-item'; //13:10 byl - place

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  File _pickedImage;
  File _pickedSecondImage;
  // PlaceLocation _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectSecondImage(File pickedSecondImage) {
    _pickedSecondImage = pickedSecondImage;
  }

  // void _selectPlace(double lat, double lng) {
  //   _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  // }

  void _saveItem() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _selectSecondImage == null ||
        _descriptionController.text.isEmpty) {
      return;
    }
    Provider.of<YourItems>(context, listen: false).addItem(
        _titleController.text,
        _descriptionController.text,
        _pickedImage,
        _pickedSecondImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Item'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(labelText: 'Description'),
                        controller: _descriptionController,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Add Item\'s photo',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Add Item\'s storage localisation',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectSecondImage),

                    // LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Item'),
            onPressed: _saveItem,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
