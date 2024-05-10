import 'package:flutter/material.dart';
import 'package:todolistproject/components/no_account_text.dart';
import 'package:todolistproject/size_config.dart';

import '../../../components/custom_suffix_icon.dart';
import '../../../components/defaut_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';

class bodyForgotPassword extends StatelessWidget {
  const bodyForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.04,),
              Text(
                "Forgot Password",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenWidth(28),
                ),
              ),
              Text(
                "Please enter your email \nand we will send you a link to return your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.1,),
              forgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class forgotPassForm extends StatefulWidget {
  const forgotPassForm({Key? key}) : super(key: key);

  @override
  State<forgotPassForm> createState() => _forgotPassFormState();
}

class _forgotPassFormState extends State<forgotPassForm> {
  final _formKey=GlobalKey<FormState>();
  List<String> errors = [];
  String? email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (newValue) => email = newValue,
          onChanged: (value) {
            if (value!.isNotEmpty && errors.contains(kEmailNullError)) {
              setState(() {
                errors.remove(kEmailNullError);
              });
            } else if (emailValidatorRegExp.hasMatch(value) &&
                errors.contains(kInvalidEmailError)) {
              setState(() {
                errors.remove(kInvalidEmailError);
              });
            }
            return null;
          },
          validator: (value) {
            if (value!.isEmpty && !errors.contains(kEmailNullError)) {
              setState(() {
                errors.add(kEmailNullError);
              });
            } else if (!emailValidatorRegExp.hasMatch(value) &&
                !errors.contains(kInvalidEmailError)) {
              setState(() {
                errors.add(kInvalidEmailError);
              });
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Email",
            hintText: "Enter your email",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: customSuffixIcon(svgIcon: "assets/icons/mail.svg"),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(30),),
        formError(errors: errors),
        SizedBox(height: SizeConfig.screenHeight! * 0.1,),
        defaultButton(
          text: "Continue",
          onPressed: () {
            if(_formKey.currentState!.validate()){
              //code gửi link qua mail
            }
          },
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.1,),
        noAccountText(),
      ],
    ));
  }
}
