import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/store/vxstore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class User extends StatefulWidget {
  const User({Key key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  bool v = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MyStore store = VxState.store;

    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: size.height / 10)),
        FadeInImage(
          imageErrorBuilder: (context, error, stackTrace) {
            return CircleAvatar(
              radius: 40,
              child: Icon(Icons.person, size: 40),
            );
          },
          placeholder: AssetImage('assets/icons/user_icon.png'),
          image: NetworkImage(
              'https://karbonless-api.herokuapp.com/users/${store.userId}/avatar'),
          height: size.width / 4,
          width: size.width / 4,
        ),
        Padding(padding: EdgeInsets.only(top: size.height / 10)),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextButton(
              onPressed: () {
                store.pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              },
              child: Text(
                'Recent Logs',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextButton(
              onPressed: () {
                AwesomeDialog(
                        btnOk: TextButton(
                          onPressed: () {
                            store.fabVisibility = true;
                            print(store.breakfastTime.minute);
                            store.setNotificationTimes();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Done",
                            style:
                                const TextStyle(color: darkGreen, fontSize: 30),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ))),
                        ),
                        context: context,
                        dialogType: DialogType.NO_HEADER,
                        dialogBackgroundColor: darkGreen,
                        body: NotificationOptions())
                    .show();
              },
              child: Text(
                'Notifications',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextButton(
              onPressed: () {
                store.pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              },
              child: Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextButton(
              onPressed: () async {
                store.fabVisibility = false;
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              child: Text(
                'Sign out',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextButton(
              onPressed: () {
                AwesomeDialog(
                  dialogBackgroundColor: darkGreen,
                  btnOk: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: const Text(
                      "Yes",
                      style: const TextStyle(color: darkGreen, fontSize: 30),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                  ),
                  btnCancel: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "No",
                      style: const TextStyle(color: darkGreen, fontSize: 30),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ))),
                  ),
                  context: context,
                  dialogType: DialogType.WARNING,
                  body: Column(
                    children: [
                      Text('Delete Account',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30)),
                      Text('Are you sure you want to delete your account?',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25)),
                    ],
                  ),
                ).show();
              },
              child: Text(
                'Delete Account',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              )),
        ),
      ],
    );
  }
}

class NotificationOptions extends StatefulWidget {
  const NotificationOptions({Key key}) : super(key: key);

  @override
  _NotificationOptionsState createState() => _NotificationOptionsState();
}

class _NotificationOptionsState extends State<NotificationOptions> {
  bool v = false;
  @override
  Widget build(BuildContext context) {
    MyStore store = VxState.store;
    return Column(
      children: [
        const Text(
          'Scheduled Notications for Food Timings',
          style: TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Switch(
            value: v,
            onChanged: (value) {
              setState(() {
                v = value;
              });
            }),
        v
            ? Column(children: [
                TextButton(
                  child: Text(
                    'Select Breakfast Time',
                    style: const TextStyle(color: darkGreen),
                  ),
                  onPressed: () async {
                    TimeOfDay breakfastTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    store.breakfastTime = breakfastTime;
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                ),
                TextButton(
                  child: Text(
                    'Select Lunch Time',
                    style: const TextStyle(color: darkGreen),
                  ),
                  onPressed: () async {
                    TimeOfDay lunchTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    store.lunchTime = lunchTime;
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                ),
                TextButton(
                  child: Text(
                    'Select Dinner Time',
                    style: const TextStyle(color: darkGreen),
                  ),
                  onPressed: () async {
                    TimeOfDay dinnerTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    store.dinnerTime = dinnerTime;
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                )
              ])
            : Container(),
      ],
    );
  }
}

Future getProfileImage() async {
  MyStore store = VxState.store;
  print(store.currentToken);
  Map headers = {'Authorization': 'Bearer ${store.currentToken}'};
  final ImagePicker _picker = ImagePicker();
  final XFile image = await _picker.pickImage(source: ImageSource.camera);
  var request = http.MultipartRequest('POST',
      Uri.parse('https://karbonless-api.herokuapp.com/users/me/avatar'));
  request.files.add(await http.MultipartFile.fromPath('avatar', image.path,
      contentType: MediaType('image', 'png')));
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  print('haha');
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
