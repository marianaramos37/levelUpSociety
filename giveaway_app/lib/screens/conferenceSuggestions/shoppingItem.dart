import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingItemWidget extends StatelessWidget {
  final String item;
  final Animation animation;
  final VoidCallback onClicked;

  const ShoppingItemWidget({
    @required this.item,
    @required this.animation,
    @required this.onClicked,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            leading: CircleAvatar(
              radius: 32,
            ),
            title: Text("ola", style: TextStyle(fontSize: 20)),
            trailing: IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green, size: 32),
              onPressed: onClicked,
            ),
          ),
        ),
      );
}
