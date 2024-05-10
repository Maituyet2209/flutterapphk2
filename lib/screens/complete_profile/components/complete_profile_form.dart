import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolistproject/screens/sign_in/sign_in_screen.dart';
import 'package:http/http.dart' as http;

import '../../../components/custom_suffix_icon.dart';
import '../../../components/defaut_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:todolistproject/config.dart';

class completeProfileForm extends StatefulWidget {
  const completeProfileForm({Key? key}) : super(key: key);

  @override
  State<completeProfileForm> createState() => _completeProfileFormState();
}

class _completeProfileFormState extends State<completeProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;


  void updateProfileUser(String email, String firstName, String lastName, String phoneNumber, String address) async {
    try {
      var regBody = {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
      };

      var response = await http.post(
        Uri.parse(updateProfile),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        Navigator.pushNamed(context, signInScreen.routeName);
      } else {
        String errorMessage = jsonResponse['error'] ?? "Something went wrong";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred")));
    }
  }


  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final Map? args = ModalRoute.of(context)!.settings.arguments as Map?;
    email = args?["email"];
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(
            height:30,
          ),
          buildLastNameFormField(),
          SizedBox(
            height:30,
          ),
          buildPhoneNumberFormField(),
          SizedBox(
            height:30,
          ),
          buildAddressFormField(),
          formError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          defaultButton(text: "Continue", onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
             updateProfileUser(email!, firstName!, lastName!, phoneNumber!, address!);
            }
          }),
        ],
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: customSuffixIcon(svgIcon: "assets/icons/user.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: customSuffixIcon(svgIcon: "assets/icons/user.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: customSuffixIcon(svgIcon: "assets/icons/phone.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: customSuffixIcon(svgIcon: "assets/icons/address.svg"),
      ),
    );
  }
}