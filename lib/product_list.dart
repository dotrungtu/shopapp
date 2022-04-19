import 'package:flutter/material.dart';
import 'package:shopapp/app_drawer.dart';
import 'package:shopapp/card_order_screen.dart';
import 'package:shopapp/model/product_item.dart';
import 'package:shopapp/provider/cart_provider.dart';

class ProductListView extends StatefulWidget {
  static const String routerName = '/product_list_view';
  const ProductListView({Key? key}) : super(key: key);

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: SizedBox(
                child: Stack(
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            CardProviderData.of(context).quantity.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            onPressed: () {
              Navigator.pushNamed(context, CardOrderScreen.routerName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const ProductItemView();
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class ProductItemView extends StatelessWidget {
  const ProductItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.network(
            'https://picsum.photos/id/1/500/500',
            fit: BoxFit.fill,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 68,
              decoration: const BoxDecoration(color: Colors.black87),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Text(
                      'style  children.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      CardProviderData.of(context).addToCart(ProductItem(
                        id: '1',
                        name: 'Product 1',
                        price: 100,
                      ));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
