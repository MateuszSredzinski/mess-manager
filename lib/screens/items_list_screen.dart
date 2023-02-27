import 'package:flutter/material.dart';
import 'package:lifemanager/models/item.dart';
import 'package:provider/provider.dart';

import '../helpers/db_helper.dart';
import './add_item_screen.dart';
import '../providers/your_items.dart';
import './item_detail_screen.dart';

class ItemsListScreen extends StatefulWidget {
  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Item> _getFilteredItems(List<Item> items, String query) {
    if (query.isEmpty) {
      return items;
    }
    final filteredItems =
        items.where((item) => item.title.contains(query)).toList();
    print('Filtered places for query "$query": $filteredItems');
    return filteredItems;
  }

  @override
  void initState() {
    super.initState();
// Przeniesienie wywołania fetchAndSetPlaces() z body do initState()
    Provider.of<YourItems>(context, listen: false).fetchAndSetItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Life manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddItemScreen.routeName);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height:
                  55.0, // ustaw wysokość kontenera na taką samą jak pole tekstowe
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    width: 1.5,
                    color: Colors.grey), // ustaw granicę na wartość zero
              ),
              child: Center(
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white), // zmiana koloru tekstu
                  decoration: InputDecoration(
                    hintText: 'Search for anything',
                    hintStyle: TextStyle(
                        color: Colors.white54), // zmiana koloru wskazówki
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                          color: Colors.white), // zmiana koloru granicy
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search,
                          color: Colors.white), // zmiana koloru ikony
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<YourItems>(
        builder: (ctx, yourItems, _) {
          final filteredItems = _getFilteredItems(
            yourItems.items,
            _searchController.text,
          );
          return filteredItems.isEmpty
              ? Center(
                  child: const Text('No items there!'),
                )
              : ListView.builder(
                  itemCount: filteredItems.length,
                  itemBuilder: (ctx, i) => Dismissible(
                    key: Key(_getFilteredItems(
                            yourItems.items, _searchController.text)[i]
                        .id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Theme.of(context).errorColor,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          _getFilteredItems(
                            yourItems.items,
                            _searchController.text,
                          )[i]
                              .image,
                        ),
                      ),
                      title: Text(
                        _getFilteredItems(
                          yourItems.items,
                          _searchController.text,
                        )[i]
                            .title,
                      ),
                      onTap: () {
                        // Go to detail page...
                        Navigator.of(context).pushNamed(
                          ItemDetailScreen.routeName,
                          arguments: yourItems.items[i].id,
                        );
                      },
                    ),
                    onDismissed: (direction) {
                      final snackBar = SnackBar(
                        content: const Text("Are You sure?"),
                        action: SnackBarAction(
                          label: "Delete!",
                          onPressed: () {
                            DBHelper.deletedata(
                                'user_items', yourItems.items[i].id);
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:lifemanager/models/item.dart';
// import 'package:provider/provider.dart';

// import '../helpers/db_helper.dart';
// import './add_item_screen.dart';
// import '../providers/your_items.dart';
// import './item_detail_screen.dart';

// class ItemsListScreen extends StatefulWidget {
//   @override
//   State<ItemsListScreen> createState() => _ItemsListScreenState();
// }

// class _ItemsListScreenState extends State<ItemsListScreen> {
//   final TextEditingController _searchController = TextEditingController();

//   List<Item> _getFilteredItems(List<Item> items, String query) {
//     if (query.isEmpty) {
//       return items;
//     }
//     final filteredItems =
//         items.where((item) => item.title.contains(query)).toList();
//     print('Filtered places for query "$query": $filteredItems');
//     return filteredItems;
//   }

//   @override
//   void initState() {
//     super.initState();
// // Przeniesienie wywołania fetchAndSetPlaces() z body do initState()
//     Provider.of<YourItems>(context, listen: false).fetchAndSetItems();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Life manager'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.of(context).pushNamed(AddItemScreen.routeName);
//             },
//           ),
//         ],
//         bottom: PreferredSize(
//           preferredSize: Size.fromHeight(55),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height:
//                   55.0, // ustaw wysokość kontenera na taką samą jak pole tekstowe
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20.0),
//                 border: Border.all(
//                     width: 1.5,
//                     color: Colors.grey), // ustaw granicę na wartość zero
//               ),
//               child: Center(
//                 child: TextField(
//                   controller: _searchController,
//                   style: TextStyle(color: Colors.white), // zmiana koloru tekstu
//                   decoration: InputDecoration(
//                     hintText: 'Search for anything',
//                     hintStyle: TextStyle(
//                         color: Colors.white54), // zmiana koloru wskazówki
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: BorderSide(
//                           color: Colors.white), // zmiana koloru granicy
//                     ),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.search,
//                           color: Colors.white), // zmiana koloru ikony
//                       onPressed: () {
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: Consumer<YourItems>(
//         builder: (ctx, yourItems, _) {
//           final filteredItems = _getFilteredItems(
//             yourItems.items,
//             _searchController.text,
//           );
//           return filteredItems.isEmpty
//               ? Center(
//                   child: const Text('No items there!'),
//                 )
//               : ListView.builder(
//                   itemCount: filteredItems.length,
//                   itemBuilder: (ctx, i) => Dismissible(
//                     key: Key(_getFilteredItems(
//                             yourItems.items, _searchController.text)[i]
//                         .id),
//                     direction: DismissDirection.endToStart,
//                     background: Container(
//                       color: Theme.of(context).errorColor,
//                       child: Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       alignment: Alignment.centerRight,
//                       padding: EdgeInsets.only(right: 20),
//                       margin: EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 4,
//                       ),
//                     ),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundImage: FileImage(
//                           _getFilteredItems(
//                             yourItems.items,
//                             _searchController.text,
//                           )[i]
//                               .image,
//                         ),
//                       ),
//                       title: Text(
//                         _getFilteredItems(
//                           yourItems.items,
//                           _searchController.text,
//                         )[i]
//                             .title,
//                       ),
//                       onTap: () {
//                         // Go to detail page...
//                         Navigator.of(context).pushNamed(
//                           ItemDetailScreen.routeName,
//                         );
//                       },
//                     ),
//                     onDismissed: (direction) {
//                       final snackBar = SnackBar(
//                         content: const Text("Are You sure?"),
//                         action: SnackBarAction(
//                           label: "Delete!",
//                           onPressed: () {
//                             DBHelper.deletedata(
//                                 'user_items', yourItems.items[i].id);
//                           },
//                         ),
//                       );
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     },
//                   ),
//                 );
//         },
//       ),
//     );
//   }
// }
