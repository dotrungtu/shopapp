import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  final String? param;
  const DetailScreen({Key? key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _param =
        param ?? ModalRoute.of(context)?.settings.arguments as String?;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail App Bar'),
        ),
        body: Column(children: [
          ElevatedButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context, 'Result from detail screen');
              } else {
                SystemNavigator.pop();
              }
            },
            child: const Text('Go back screen'),
          ),
          Text('Param receiver: $_param')
        ]),
      ),
    );
  }
}
