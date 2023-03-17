import 'package:flutter/material.dart';
import 'package:pertamina_test/ui/form_screen.dart';

IconButton floatButCust(double height, BuildContext context) {
  return IconButton(
    icon: Icon(
      Icons.add_box,
      size: height * 0.07,
      color: Colors.grey,
    ),
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormScreen(
              mode: 'add',
              id: '',
              itemName: '',
              barcode: '',
            ),
          ));
    },
  );
}

AppBar viewAppBar(BuildContext context) {
  return AppBar(
    title: Center(child: Text('List Item')),
    elevation: 0,
    backgroundColor: Colors.grey,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        tooltip: "Add Item",
        onPressed: () {
           Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormScreen(
              mode: 'add',
              id: '',
              itemName: '',
              barcode: '',
            ),
          ));
        },
      )
    ],
  );
}
