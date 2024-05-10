import 'package:flutter/material.dart';
import 'package:todolistproject/constants.dart';

class IconSettings extends StatelessWidget {
  const IconSettings({super.key});

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
                Icons.settings,
                color: kTextWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
