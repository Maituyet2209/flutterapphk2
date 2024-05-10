import 'package:flutter/material.dart';

class DetailsGroup extends StatelessWidget {
  const DetailsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> nembers = [
      {"name": "Johnny Doe", },
      {"name": "Foria", },
      {"name": "Sena",},
    ];
    return SafeArea(
      child: ListView(
        children: List.generate(
          nembers.length,
              (index) => itemGridView(
            name: nembers[index]["name"],

            press: () {},
          ),
        ),
      ),
    );
  }
}

class itemGridView extends StatelessWidget {
  const itemGridView(
      {Key? key, required this.name, required this.press})
      : super(key: key);
  final String name;
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
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
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