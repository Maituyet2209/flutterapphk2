import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todolistproject/screens/group/group_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'section_title.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../config.dart';

class ListTeams extends StatefulWidget {
  final token;
  const ListTeams({Key? key, required this.token}) : super(key: key);

  @override
  State<ListTeams> createState() => _ListTeamsState();
}

class _ListTeamsState extends State<ListTeams> {
  late String userId;
  List<dynamic>? items;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    //GetUserTeam(userId);
  }

  // void GetUserTeam(userId) async {
  //   var regBody = {"userId": userId};
  //   var response = await http.post(Uri.parse(getUserTeams),
  //       headers: {"Content-Type": "application/json"},
  //       body: jsonEncode(regBody));
  //   var jsonResponse = jsonDecode(response.body);
  //   setState(() {
  //     items = jsonResponse['success'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Your teams",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TeamCard(
                image: "assets/images/splash2.png",
                nameTeam: "Team's name 1",
                numOfTasks: 18,
                press: () {
                  Navigator.pushNamed(context, groupScreen.routeName);
                },
              ),
              TeamCard(
                image: "assets/images/splash2.png",
                nameTeam: "Team's name 2",
                numOfTasks: 24,
                press: () {
                  Navigator.pushNamed(context, groupScreen.routeName);
                },
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class TeamCard extends StatelessWidget {
  const TeamCard({
    Key? key,
    required this.nameTeam,
    required this.image,
    required this.numOfTasks,
    required this.press,
  }) : super(key: key);

  final String nameTeam, image;
  final int numOfTasks;
  final GestureTapCallback press;
  final maxMembers = 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 250,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                // Image.asset(
                //   image,
                //   fit: BoxFit.cover,
                // ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.lightBlue
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Colors.white,
                    //     Colors.transparent,
                    //   ],
                    // ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(color: Colors.white),
                          children: [
                            TextSpan(
                              text: "$nameTeam\n",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "$numOfTasks Task")
                          ],
                        ),
                      ),
                      Spacer(),
                      CircularPercentIndicator(
                        backgroundColor: Colors.white,
                        animation: true,
                        radius: 25.0,
                        lineWidth: 6.0,
                        percent: 0.75, // Phần trăm hoàn thành công việc (từ 0 đến 1)
                        center: Text("75%"), // Hiển thị phần trăm ở trung tâm
                        progressColor: Colors.blue,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Stack(
                    children: [
                      ...List.generate(
                        maxMembers, // Số lượng thành viên
                            (index) {
                          return Positioned(
                            bottom: 0,
                            left: index * 25.0, // Điều chỉnh khoảng cách giữa các CircleAvatar
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white, // Màu của viền
                                  width: 2.0, // Độ dày của viền
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 15, // Kích thước của CircleAvatar
                                backgroundImage: AssetImage('assets/images/avatar1.png'), // Thay đổi ảnh đại diện từ dữ liệu API
                              ),
                            ),
                          );
                        },
                      ),
                      if (maxMembers < 4) // Nếu số lượng thành viên lớn hơn 3, hiển thị CircleAvatar với dấu cộng
                        Positioned(
                          bottom: 0,
                          left: maxMembers * 25.0, // Điều chỉnh khoảng cách giữa các CircleAvatar
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white, // Màu của viền
                                width: 2.0, // Độ dày của viền
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 15, // Kích thước của CircleAvatar
                              child: Icon(
                                Icons.add, // Icon dấu cộng
                                color: Colors.white, // Màu của icon
                              ),
                              backgroundColor: Colors.blue, // Màu nền của CircleAvatar
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}