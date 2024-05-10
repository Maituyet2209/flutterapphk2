import 'package:flutter/material.dart';
import 'package:todolistproject/constants.dart';
import 'package:todolistproject/screens/sign_in/sign_in_screen.dart';
import 'package:todolistproject/screens/splash/components/splash_content.dart';
import 'package:todolistproject/size_config.dart';
import 'package:todolistproject/screens/splash/splash_screen.dart';
import '../../../components/defaut_button.dart';

class bodySplash extends StatefulWidget {
  const bodySplash({super.key});

  @override
  State<bodySplash> createState() => _bodySplashState();
}

class _bodySplashState extends State<bodySplash> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to TimeWise! Explore our world of time.",
      "image": "assets/images/splash1.png"
    },
    {
      "text": "We help you manage tasks and time more effectively.",
      "image": "assets/images/splash2.png"
    },
    {
      "text": "Time is precious, don't waste it.",
      "image": "assets/images/splash3.png"
    },
    {
      "text": "The app experience won't disappoint you.",
      "image": "assets/images/splash4.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => splashContent(
                    text: splashData[index]["text"] ?? "",
                    image: splashData[index]["image"] ?? "",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(),
                      defaultButton(
                        text: "Skip",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signInScreen()));
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
      duration: kAnimationDuration,
    );
  }
}
