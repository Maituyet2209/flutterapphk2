import 'package:flutter/material.dart';

class itemGridView extends StatelessWidget {
  const itemGridView(
      {Key? key, required this.name, required this.color, required this.press})
      : super(key: key);
  final String name, color;
  final GestureTapCallback press;

  Color getColorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 50,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: getColorFromHex(color)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: getColorFromHex(color),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 10),
                Text(name),
              ],
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit_outlined,
                color: Colors.green,
                size: 20,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 20,
              )),
        ],
      ),
    );
  }
}