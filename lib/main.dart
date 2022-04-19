import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shopapp/card_order_screen.dart';
import 'package:shopapp/product_list_screen.dart';
import 'package:shopapp/inherited_widget.dart';
import 'package:shopapp/model/product_item.dart';
import 'package:shopapp/product_form.dart';
import 'package:shopapp/product_list_view.dart';
import 'package:shopapp/provider/cart_provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthenticationData(
      child: CardProviderData(
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Shop App',
            theme: ThemeData(
              primarySwatch: Colors.purple,
            ),
            debugShowCheckedModeBanner: false,
            home: AuthenticationData.of(context).isAuthenticated
                ? const ProductListScreen()
                : const Bai4(),
            onGenerateRoute: (RouteSettings settings) {
              log(settings.name ?? '');
              final List<String> pathElements = settings.name?.split('/') ?? [];
              if (pathElements[0] != '') {
                return null;
              }
              if (settings.name == ProductListScreen.routerName) {
                return MaterialPageRoute<void>(
                  settings: settings,
                  builder: (BuildContext context) => const ProductListScreen(),
                );
              }
              if (settings.name == ProductForm.routerName) {
                return MaterialPageRoute<ProductItem>(
                  settings: settings,
                  builder: (BuildContext context) => const ProductForm(),
                );
              }
              if (settings.name == ProductListView.routerName) {
                return MaterialPageRoute<ProductItem>(
                  settings: settings,
                  builder: (BuildContext context) => const ProductListView(),
                );
              }
              if (settings.name == CardOrderScreen.routerName) {
                return MaterialPageRoute<ProductItem>(
                  settings: settings,
                  builder: (BuildContext context) => const CardOrderScreen(),
                );
              }
              return null;
            },
          );
        }),
      ),
    );
  }
}

class Bai4 extends StatefulWidget {
  const Bai4({Key? key}) : super(key: key);

  @override
  State<Bai4> createState() => _Bai4State();
}

class _Bai4State extends State<Bai4> {
  FormType _formType = FormType.login;

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pink.withAlpha(50), Colors.orange])),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RotationTransition(
                turns: const AlwaysStoppedAnimation(-15 / 360),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.red.withAlpha(100),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'MY SHOP',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      if (_formType == FormType.register)
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Re-Password',
                            prefixIcon: Icon(Icons.password),
                          ),
                        ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, ProductList.routerName,
                          //     arguments: _emailController.text);
                          AuthenticationData.of(context)
                              .setUserName(_emailController.text);
                        },
                        child: Text(
                            _formType == FormType.login ? 'LOGIN' : 'SIGN UP'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent),
                        onPressed: () {
                          setState(() {
                            _formType = _formType == FormType.login
                                ? FormType.register
                                : FormType.login;
                          });
                        },
                        child: Text(
                          _formType == FormType.login
                              ? 'SIGNUP INSTEAD'
                              : 'LOGIN INSTEAD',
                          style:
                          TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

enum FormType {
  login,
  register,
}
