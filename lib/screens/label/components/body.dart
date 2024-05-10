import 'package:flutter/material.dart';
import 'package:todolistproject/size_config.dart';

import 'list_label.dart';

class bodyLabel extends StatelessWidget {
  const bodyLabel({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> labels = [
      {"name": "High", "color": "#ff0000"},
      {"name": "Medium", "color": "#ffff00"},
      {"name": "Low", "color": "#0400ff"},
    ];

    return SafeArea(
      child: ListView(
        children: List.generate(
          labels.length,
          (index) => itemGridView(
            name: labels[index]["name"],
            color: labels[index]["color"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

