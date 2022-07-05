import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rapid_note/screens/home_screen/home_screen.dart';
import 'package:rapid_note/screens/register/register.dart';
import '../../../constants/reusable.dart';
import '../../../constants/login_color_gradient.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo1.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                firebaseUIButton(context, "Sign In", () async {
                  print("test");
                  await printData(
                      _passwordTextController.text, _emailTextController.text);
                  print("finish");
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  printData(String secret1, String email) async {
    // https://athena-a6clm7lhrq-oa.a.run.app/classify
    // http://41.179.247.136:6000/inference

    print("test2");

    var url = "https://athena-a6clm7lhrq-oa.a.run.app/secret";

    Dio dio = new Dio();
    var data2 = {"e_mail": email, "secret": secret1};
    print(data2);
   /*  var res = await dio.post(url, data: data2);

    print(res); */

     dio.post(url, data: data2).then((response) {
      print(secret1);
      print(response);
      if (response.statusCode == 200) {
        setState(() {
          print(response);
          Navigator.push(context, _customRoute());
        });
      }
    }).catchError((error) {
      {
        Navigator.push(context, _customRoute2());
      }
    }); 
  }

  Route _customRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
    );
  }

  Route _customRoute2() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
    );
  }
}
