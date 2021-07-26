import 'package:flutter/widgets.dart';
import 'package:market/screens/cart/cart_page.dart';
import 'package:market/screens/login/login_page.dart';

const String CartRoute = "/cart";

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CartRoute:
      return getPageRoute(CartPage(cartBloc: settings.arguments), settings);
    default:
      return getPageRoute(LoginPage(), settings);
  }
}

PageRoute getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
