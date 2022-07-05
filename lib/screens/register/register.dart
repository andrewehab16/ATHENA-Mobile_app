import 'dart:convert';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rapid_note/screens/home_screen/home_screen.dart';
import '../../../constants/reusable.dart';
import '../../../constants/login_color_gradient.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../constants/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                Center(
                  child: Text("NOT FOUND PLEASE REGISTER ON OUR WEBSITE",
                      maxLines: 4,
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 5,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
