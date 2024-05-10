import 'package:flutter/material.dart';

import '../constants.dart';
import 'menu_dialog.dart';
class ButtonShowOptions extends StatelessWidget {
  final token;
  const ButtonShowOptions({@required this.token,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showDialogMenu() {
      showModalBottomSheet(
        barrierColor: Color.fromRGBO(0,0,0, 0.6),
        context: context,
        builder: (BuildContext context) {
          return customMenuDialog(token: token,);
        },
      );
    }
    return FloatingActionButton(
      onPressed: () {
        _showDialogMenu();
      },
      child: Icon(
        Icons.edit_outlined,
        color: Colors.white,
      ),
      backgroundColor: kPrimaryColor,
      splashColor: Colors.deepOrange,
    );
  }
}
