import 'package:flutter/material.dart';
import 'package:turalura/services/auth_service.dart';

class Provider extends InheritedWidget {
  final AuthService auth;
  Provider({Key key, Widget child, this.auth}) : super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  // Deprecated
  // static Provider of(BuildContext context) => (context.inheritFromWidgetOfExactType(Provider) as Provider);

  static Provider of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<Provider>());
}