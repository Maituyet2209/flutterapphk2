import 'package:flutter/material.dart';

import 'form_create_task.dart';
import 'form_create_team.dart';

class customMenuDialog extends StatelessWidget {
  final token;
  const customMenuDialog({@required this.token,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.blue.withOpacity(0.5), // Màu shadow tùy chỉnh
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: Offset(0, 3), // Điều chỉnh vị trí shadow
        //   ),
        // ],
      ),
      height: 350,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                splashColor: Colors.greenAccent,
                leading: Icon(Icons.task_alt_rounded, color: Colors.blue,),
                title: Text('Create Task', style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => createTask(token: token,)));
                },
              ),
              SizedBox(height: 20,),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                splashColor: Colors.greenAccent,
                leading: Icon(Icons.event_outlined, color: Colors.purple,),
                title: Text('Create Event', style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: (){

                },
              ),
              SizedBox(height: 20,),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                splashColor: Colors.greenAccent,
                leading: Icon(Icons.groups_outlined,color: Colors.red,),
                title: Text('Create Team', style: TextStyle(fontWeight: FontWeight.bold),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupForm(token: token,)));
                },
              ),
            ],
          ),
        ),
    );
  }
}