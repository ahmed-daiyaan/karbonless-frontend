import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/sign_up_details.dart';
//import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
//import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/components/rounded_confirm_password_field.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../constants.dart';
//import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;
  String password;
  String name;
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Text(
              "SIGNUP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            //SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/signup.svg",
            //   height: size.height * 0.35,
            // ),
            Image.asset(
              "assets/images/earth.png",
              width: size.width * 0.8,
            ),
            RoundedInputField(
              hintText: "Your Name",
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            // //re-enter passowrd?
            // RoundedPasswordField(
            //   onChanged: (value) {},
            // ),
            RoundedButton(
              text: "SIGNIN",
              press: () async {
                FocusScope.of(context).unfocus();
                SignUpDetails signUpDetails =
                    await signUp(name, email, password);
                if (signUpDetails == null) {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          showCloseIcon: true,
                          body: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AutoSizeText(
                              'Please ensure whether email is valid and password contains a minimum of 6 characters',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ),
                          closeIcon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          dialogBackgroundColor: darkGreen)
                      .show();
                } else {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('karbonizeToken', signUpDetails.token);
                  preferences.setString(
                      'karbonizeName', signUpDetails.user.name);
                  store.fabVisibility = true;

                  store.currentToken = signUpDetails.token;
                  store.currentUser = signUpDetails.user.name;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                }
              },
            ),
            //SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<SignUpDetails> signUp(String name, String email, String password) async {
  print('$name, $email, $password');
  Map body = {'name': name, 'email': email, 'password': password};

  var response = await http.post(
      Uri.https('karbonless-api.herokuapp.com', '/users'),
      body: json.encode(body),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  print(response.statusCode);
  if (response.body.startsWith('E11000 duplicate key error')) {
    Map signBody = {'email': email, 'password': password};
    var signResponse = await http.post(
        Uri.https('karbonless-api.herokuapp.com', '/users/login'),
        body: json.encode(signBody),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    print(response.body);
    return signUpDetailsFromJson(signResponse.body);
  } else if (response.body.startsWith('User validation failed')) {
    return null;
  } else {
    return signUpDetailsFromJson(response.body);
  }
}
