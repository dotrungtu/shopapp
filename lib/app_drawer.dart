import 'package:flutter/material.dart';
import 'package:shopapp/product_list_screen.dart';
import 'package:shopapp/product_list_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Product List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProductListView.routerName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProductListScreen.routerName);
            },
          ),
        ],
      ),
    );
  }
}
