import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class defaultButton extends StatelessWidget {
  const defaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(60),
      child: ElevatedButton(
        onPressed: () {
          onPressed(); // Gọi hàm xử lý chuyển hướng
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
