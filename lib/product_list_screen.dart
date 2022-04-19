import 'package:flutter/material.dart';
import 'package:shopapp/app_drawer.dart';
import 'package:shopapp/inherited_widget.dart';
import 'package:shopapp/model/product_item.dart';
import 'package:shopapp/product_form.dart';

class ProductListScreen extends StatefulWidget {
  static const routerName = '/product_list_screen';
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<ProductItem> productItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(
            'Product List - ${AuthenticationData.of(context).isAuthenticated ? 'Manage' : 'Not Authenticated'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final productResult = await Navigator.pushNamed<ProductItem>(
                  context, ProductForm.routerName);
              if (productResult != null) {
                setState(() {
                  productItems.any((element) => element.id == productResult.id)
                      ? null
                      : productItems.add(productResult);
                });
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final product = productItems[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            elevation: 8.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(product.imageUrl ?? ''),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      product.name ?? '',
                      style:
                      const TextStyle(fontSize: 15.0, color: Colors.black),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final productResult =
                        await Navigator.pushNamed<ProductItem>(
                            context, ProductForm.routerName,
                            arguments: product);
                        if (productResult != null) {
                          setState(() {
                            productItems[index] = productResult;
                          });
                        }
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                actions: [
                                  ElevatedButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ElevatedButton(
                                    child: const Text('Yes'),
                                    onPressed: () {
                                      setState(() {
                                        productItems.removeWhere((element) =>
                                        element.id == product.id);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      }),
                ],
              ),
            ),
          );
        },
        itemCount: productItems.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
