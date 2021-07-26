import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CartButton({Key key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      width: 40.0,
      child: IconButton(
        icon: Icon(icon),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () => onPressed(),
      ),
    );
  }
}
