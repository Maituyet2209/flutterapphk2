import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../config.dart';
import '../layout/myBottomNavigation.dart';
import 'input_field.dart';

class CreateGroupForm extends StatefulWidget {
  final token;
  const CreateGroupForm({Key? key, this.token}) : super(key: key);

  @override
  State<CreateGroupForm> createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _formKey = GlobalKey<FormState>();
  late String userId;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
  }


  void CreateTeam() async {
    if (_nameController.text.isNotEmpty) {
      Map<String, dynamic> regBody = {
        "owner": userId,
        "name": _nameController.text,
        "description": _descriptionController.text,
      };

      try {
        var response = await http.post(
          Uri.parse(createTeam),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 201) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse is Map && jsonResponse.containsKey('success')) {
            if (jsonResponse['success'] is bool && jsonResponse['success']) {
              _nameController.clear();
              _descriptionController.clear();
              Navigator.push(context, MaterialPageRoute(builder: (context) => myBottomNavBar(token: widget.token)));
            } else {
              print("Something went wrong");
            }
          } else {
            print("Invalid response format: $jsonResponse");
          }
        } else {
          print("Failed to create task. Status code: ${response.statusCode}");
        }
      } catch (error) {
        print("Error creating team: $error");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create your team",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Group Name'),
                  validator: RequiredValidator(errorText: 'Please enter a group name'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description (Optional)'),
                ),
                SizedBox(
                  height: 20,
                ),
                    ElevatedButton(
                      onPressed: () {
                        CreateTeam();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      ),
                      child: Text(
                        "Create Team",
                        style: TextStyle(
                          color: Colors.white, // Đặt màu văn bản của button là trắng
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   child: Form(
    //     key: _formKey,
    //     child: Column(
    //       children: [
    //         TextFormField(
    //           controller: _nameController,
    //           decoration: const InputDecoration(labelText: 'Group Name'),
    //           validator: RequiredValidator(errorText: 'Please enter a group name'),
    //         ),
    //         TextFormField(
    //           controller: _descriptionController,
    //           decoration: const InputDecoration(labelText: 'Description (Optional)'),
    //         ),
    //         // Add buttons for submitting the form and handling member selection (explained later)
    //       ],
    //     ),
    //   ),
    // );
  }
}
