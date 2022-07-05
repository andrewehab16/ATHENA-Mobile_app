import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_note/screens/recordings_list/view/recordings_list_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class TranscribeScreen extends StatefulWidget {
  static const routeName = '/transcribescreen';
  var PassedPath;
  TranscribeScreen(this.PassedPath);
  @override
  State<StatefulWidget> createState() => _TranscribeScreenState();
}

class _TranscribeScreenState extends State<TranscribeScreen> {
  var ReturnedResponse;
  bool loading = true;
  String Transcript = '';
  String Sentiment = '';
  String Score = '';
  String Transcripth = '';
  String Sentimenth = '';
  String Scoreh = '';
  int state = 0;

  Future printData(String path) async {
    // https://athena-a6clm7lhrq-oa.a.run.app/classify
    // http://41.179.247.136:6000/inference
    if (state < 1) {
      var url = "https://athena-a6clm7lhrq-oa.a.run.app/audio";

      String filePath = path;
      File dir = File(path);

      String fileName = filePath.split('/').last;
      print(fileName);

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          filePath,
          filename: fileName,
        ),
      });

      Dio dio = new Dio();

      dio.post(url, data: data).then((response) {
        if (response.statusCode == 200) {
          setState(() {
            print(response);
            Transcripth = "Transcript";
            Sentimenth = "Sentiment";
            Scoreh = "Score";
            Transcript = response.data[0]['Transcript'];
            Sentiment = response.data[0]['Sentiment'];
            Score = response.data[0]['Score'].toString();
            state += 1;
            loading = false;
          });
        }
      }).catchError((error) {
        {
          setState(() {
            Transcripth = "";
            Sentimenth = "TRY AGAIN";
            Scoreh = "";
            Transcript = "";
            Sentiment = "";
            Score = '';
            state += 1;
            loading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    printData(widget.PassedPath);

    if (loading)
      return Center(
          child: CircularProgressIndicator(color: AppColors.accentColor));

    //print(ReturnedResponse);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.mainColor,
          body: Container(
            padding: const EdgeInsets.all(60),
            child: Center(
              child: Column(children: <Widget>[
                Text(
                  Transcripth,
                  maxLines: 3,
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5,
                  ),
                  /* decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Score, 
                          hintText: */
                ),
                SizedBox(height: 10),
                Text(
                  Transcript,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.accentColor, fontSize: 20),
                  /* decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Score, 
                          hintText: */
                ),
                SizedBox(height: 100),
                Text(
                  Sentimenth,
                  maxLines: 3,
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5,
                  ),
                  /* decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Score, 
                          hintText: */
                ),
                SizedBox(height: 10),
                Text(
                  Sentiment,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.accentColor, fontSize: 20),
                  /* decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Score, 
                          hintText: */
                ),
                SizedBox(height: 100),
                Text(
                  Scoreh,
                  maxLines: 3,
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5,
                  ),
                  /* decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Score, 
                          hintText: */
                ),
                SizedBox(height: 10),
                Text(
                  Score,
                  maxLines: 3,
                  style: TextStyle(color: AppColors.accentColor, fontSize: 20),
                  /* decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: Score, 
                          hintText: */
                ),
              ]),
            ),
          ),
        ));
  }
}
