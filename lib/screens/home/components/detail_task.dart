import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailTask extends StatefulWidget {
  final dynamic task;

  const DetailTask({super.key, this.task});

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data",
                  style: TextStyle(fontFamily: "Readex", fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text('Mark as complete'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 3.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.notifications_on_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                      Text('Remind me'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    elevation: 3.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    // Xử lý khi nút được nhấn
                  },
                  child: Text('Add Tag'),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.grey,
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    side: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                      style: BorderStyle.solid, // Thay đổi kiểu đường viền sang dashed
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Data",
                  style: TextStyle(fontFamily: "Readex", fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0), // Set border radius for rounded corners
                    border: Border.all(  // Add a border
                      color: Colors.grey, // Set border color
                      width: 1.0, // Set border width
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: Row(
                    children: [
                      Icon(Icons.circle_outlined),
                      SizedBox(width: 5,),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add a new subtask',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Note",
                  style: TextStyle(fontFamily: "Readex", fontSize: 20),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0), // Set border radius for rounded corners
                          border: Border.all(  // Add a border
                            color: Colors.grey, // Set border color
                            width: 1.0, // Set border width
                          ),
                        ),
                        child: OutlinedButton(
                          onPressed: () {
                            // Xử lý khi nút được nhấn
                          },
                          child: Text('Tap to add note'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.grey,
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                              style: BorderStyle.none, // Thay đổi kiểu đường viền sang dashed
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
