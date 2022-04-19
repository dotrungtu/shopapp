import 'package:flutter/material.dart';

import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home App Bar'),
      ),
      body: Column(children: [
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetailScreen(
                  param: 'Hello',
                ),
              ),
            );
            print('Result: $result');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Result: $result'),
              ),
            );
          },
          child: const Text('Cach 1. Khoi tao navigator va push screen'),
        ),
        const Divider(),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, DetailScreen.routeName);
          },
          child: const Text('Cach 2. Su dung static routers'),
        ),
        const Divider(),
        ElevatedButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(
                context, DetailScreen.routeName,
                arguments: 'Hello 3');
            print('Result 3: $result');
          },
          child: const Text('Cach 3. Su dung generate routers'),
        ),
      ]),
    );
  }
}
