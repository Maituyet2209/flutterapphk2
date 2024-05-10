import 'package:flutter/material.dart';
import 'package:todolistproject/constants.dart';

class IconNotification extends StatelessWidget {
  const IconNotification({super.key, required this.numOfNotify});
  final int numOfNotify;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: (){},
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: kTextWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.notifications_active_sharp,
                color: kTextWhite,
              ),
            ),
          ),
          if (numOfNotify != 0)
            Positioned(
              right: 0,
              child: Container(
                height:15,
                width: 15,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfNotify",
                    style: TextStyle(
                      fontSize: 10,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
