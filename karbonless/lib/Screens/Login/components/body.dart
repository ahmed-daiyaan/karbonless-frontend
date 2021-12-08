import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/sign_up_details.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

//import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 40.0,
              ),
            ),
            //SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
            Image.asset(
              "assets/images/earth.png",
              width: size.width * 0.8,
            ),
            SizedBox(height: size.height * 0.03),
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
            RoundedButton(
              text: "LOGIN",
              press: () async {
                FocusScope.of(context).unfocus();
                SignUpDetails signUpDetails = await signIn(email, password);
                if (signUpDetails == null) {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          showCloseIcon: true,
                          body: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: AutoSizeText(
                              'User does not exist',
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainScreen();
                  }));
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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

Future<SignUpDetails> signIn(String email, String password) async {
  print('$email, $password');
  Map signBody = {'email': email, 'password': password};
  var signResponse = await http.post(
      Uri.https('karbonless-api.herokuapp.com', '/users/login'),
      body: json.encode(signBody),
      headers: {HttpHeaders.contentTypeHeader: 'application/json'});
  print(signResponse.statusCode);
  print(signResponse.body);
  if (signResponse.statusCode == 200)
    return signUpDetailsFromJson(signResponse.body);
  else
    return null;
}
