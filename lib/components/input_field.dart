import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({Key?key, required this.title, required this.hint, this.controller, this.widget}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
        Container(
          padding: EdgeInsets.only(left: 15),
          margin: EdgeInsets.only(top: 8),
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Expanded(
                 child: TextFormField(
                   readOnly: widget == null ? false:true,
                autofocus: false,
                cursorColor: Colors.blueAccent,
                controller: controller,
                style: TextStyle(fontSize: 16, color: Colors.grey),
                   decoration: InputDecoration(
                     hintText: hint,
                     border: InputBorder.none,
                   ),
              ),
              ),
              widget == null ?Container():Container(child: widget,)
            ],
          ),
        ),
        ],
      ),
    );
  }
}
