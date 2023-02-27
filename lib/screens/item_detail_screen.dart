import 'package:flutter/material.dart';
import 'package:lifemanager/models/item.dart';
import 'package:lifemanager/providers/your_items.dart';
import 'package:provider/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  static const routeName = '/item-detail';



  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;

    final selectedItem = Provider.of<YourItems>(
      context,
      listen: false,
    ).findById(id);

    

    print('Justynka2 $id');

    // yourItems.items[i].id;

    // _getFilteredItems(yourItems.items, _searchController.text)[i].id;
    print('Justynka $selectedItem');

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedItem.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              selectedItem.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              selectedItem.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedItem.secondimage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
