import 'package:flutter/material.dart';

class AuthenticationData extends StatefulWidget {
  final Widget child;
  const AuthenticationData({
    Key? key,
    required this.child,
  }) : super(key: key);

  static AuthenticationDataState of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_AuthInheritedWidget>())!
        .data;
  }

  @override
  State<AuthenticationData> createState() => AuthenticationDataState();
}

class AuthenticationDataState extends State<AuthenticationData> {
  String? userName;

  bool get isAuthenticated {
    return userName?.isNotEmpty == true;
  }

  void setUserName(String? userName) {
    setState(() {
      this.userName = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _AuthInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _AuthInheritedWidget extends InheritedWidget {
  final AuthenticationDataState data;

  const _AuthInheritedWidget(
      {Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
