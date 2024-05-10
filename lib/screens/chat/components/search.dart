import 'package:flutter/material.dart';
class searchIcon extends StatelessWidget {
  const searchIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.orange,
      ),
      child: Icon(
        Icons.search,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
