import 'package:flutter/material.dart';
import 'package:todolistproject/screens/label/components/body.dart';

class listLabelScreen extends StatelessWidget {
  const listLabelScreen({super.key});
  static String routeName="/label";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labels"),
        centerTitle: true,
      ),
      body: bodyLabel(),
    );
  }
}
