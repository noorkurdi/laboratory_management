import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:university_project/bloc/app_cubit.dart';
import 'package:university_project/bloc/app_states.dart';
import 'package:university_project/core/utils/app_constants.dart';
import 'package:university_project/pages/on_boarding_screen/on_boarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final sp = await SharedPreferences.getInstance();
  runApp(
    BlocProvider<AppCubit>(
      create: (context) => AppCubit(sharedPreferences: sp)..initialEvent(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit appCubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'laboratory',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: AnimatedSplashScreen(
                splashIconSize: 350,
                splash: Image.asset(AppImages.appLogoPath),
                nextScreen:
                    // LogInPage()
                    //  appCubit.onBoarding()
                const OnBoarding()
                // appCubit.rememberUser(
                //   onBoarding: OnBoarding(),
                //     login: LogInPage(),
                //     admin: const AdminHomePage(),
                //     doctor: const DoctorHomePage(),
                //     employee: const EmployeeHomePage())
                // HomePage()
           
    
                ),
          );
        });
  }
}
