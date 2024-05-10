import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class profilePic extends StatelessWidget {
  const profilePic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/avatar.png"),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: SizedBox(
              height: 45,
              width: 45,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: const BorderSide(color: Colors.white),
                ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: (){},
                child: SvgPicture.asset("assets/icons/camera.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}