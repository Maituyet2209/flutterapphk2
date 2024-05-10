
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../constants.dart';


class greetingsHeader extends StatefulWidget {
  final token;
  const greetingsHeader({Key? key,@required this.token})
      : super(key: key);

  @override
  State<greetingsHeader> createState() => _greetingsHeaderState();
}

class _greetingsHeaderState extends State<greetingsHeader> {
  late String firstName;
  late String lastName;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token);

    firstName = jwtDecodeToken['firstName'];
    lastName = jwtDecodeToken['lastName'];
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEE, dd MMMM yyyy").format(now);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello $firstName $lastName",
          style: TextStyle(
            color: kTextWhite,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 15,
            color: kTextWhite,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
