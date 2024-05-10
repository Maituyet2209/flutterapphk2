import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/screens/chat/components/search.dart';
import 'card_task.dart';
import 'home_calender.dart';

class bodyHome extends StatelessWidget {
  final token;
  const bodyHome({@required this.token,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 35, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //myCalendarHome(press: (){}),
              Row(
                children: [
                  Spacer(),
                  searchIcon(),
                ],
              ),
              SizedBox(height: 20,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("In Progress", style: TextStyle(fontSize: 20, color:kPrimaryColor),),
              //     Icon(Icons.keyboard_arrow_right_rounded, color: kPrimaryColor,)
              //   ],
              // ),
               //Expanded(child: CardList(token: token,)),
            ],
          ),
        ),
      ),
    );
  }
}