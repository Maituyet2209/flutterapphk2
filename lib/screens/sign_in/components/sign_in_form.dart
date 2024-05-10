import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolistproject/screens/forgot_password/forgot_password_screen.dart';
import 'package:todolistproject/screens/login_success/login_success_screen.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/defaut_button.dart';
import '../../../components/form_error.dart';
import '../../../config.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class signInForm extends StatefulWidget {
  const signInForm({super.key});

  @override
  State<signInForm> createState() => _signInFormState();
}

class _signInFormState extends State<signInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  late SharedPreferences prefs;
  bool remember = false;
  final List<String> errors = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      var reqBody = {
        "email": email,
        "password": password,
      };
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        var myToken = jsonResponse['token'];
        prefs = await SharedPreferences.getInstance();
        prefs.setString('token', myToken);
        Navigator.push(context, MaterialPageRoute(builder: (context) => loginSuccessScreen(token: myToken,)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse['message']),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      print("Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred"),
        backgroundColor: Colors.red,
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, forgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          formError(errors: errors),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          defaultButton(
            text: "Login",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                loginUser(email!, password!);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            removeError(error: kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            removeError(error: kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            addError(error: kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            addError(error: kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: customSuffixIcon(svgIcon: "assets/icons/mail.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value!.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            removeError(error: kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            removeError(error: kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            addError(error: kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            addError(error: kShortPassError);
          });
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: customSuffixIcon(svgIcon: "assets/icons/lock.svg"),
      ),
    );
  }


}
