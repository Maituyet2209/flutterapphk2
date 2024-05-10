import 'package:flutter/material.dart';

import 'avatar.dart';
class avatarList extends StatelessWidget {
  const avatarList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),// Khi cuộn đến cuối danh sách sẽ quay về đầu
        scrollDirection: Axis.horizontal,//tạo ra thanh cuộn ngang
        shrinkWrap: true,//có thể cuộn dù chỉ 1 item, tối ưu hóa không gian
        itemCount: 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Avatar(
                margin: EdgeInsets.only(right: 15),
                image: 'assets/images/avatar1.png',
              ),
              Avatar(
                margin: EdgeInsets.only(right: 15),
                image: 'assets/images/avatar2.png',
              ),
              Avatar(
                margin: EdgeInsets.only(right: 15),
                image: 'assets/images/avatar3.png',
              ),
            ]
          );
        },
      ),
    );
  }
}
