import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_note/screens/transcribe_screen/view/transcribe_screen.dart';
import 'constants/app_colors.dart';
import 'screens/home_screen/cubit/record/record_cubit.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/recordings_list/view/recordings_list_screen.dart';
import 'package:rapid_note/screens/log_in/login.dart';
import 'screens/recordings_list/cubit/files/files_cubit.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Sets navigation bar color accoring to our prefs
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.mainColor, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<RecordCubit>(
          create: (context) => RecordCubit(),
        ),

        /// [FilesCubit] is provided before material app because it should start loading all files when app is opens
        /// asynschronous method [getFiles] is called in constructor of [Files Cubit].
        BlocProvider<FilesCubit>(
          create: (context) => FilesCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'ATHENA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SignInScreen.routeName,
        //initialRoute: HomeScreen.routeName,
        routes: {
          SignInScreen.routeName: (context) => SignInScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          RecordingsListScreen.routeName: (context) => RecordingsListScreen(),
          TranscribeScreen.routeName: (context) => TranscribeScreen(''),
        },
      ),
    );
  }
}
