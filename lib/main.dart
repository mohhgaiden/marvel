import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:marval/bookmark/database/bookmark_manager.dart';
import 'package:marval/home/ui/page/main.dart';
import 'package:marval/login/cubit/auth/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marval/login/cubit/login/login_cubit.dart';
import 'package:marval/login/cubit/register/register_cubit.dart';
import 'package:marval/login/ui/page/login.dart';
import 'home/cubit/chars_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(await FirebaseMessaging.instance.getToken());
  await Get.put(BookMarkManager());
  appConfig();
  runApp(MyApp());
}

appConfig() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Marvel',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        child: BlocBuilder<AuthCubit,AuthState>(builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<CharsCubit>(create: (context) => CharsCubit()),
              BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
              BlocProvider<LoginCubit>(create: (context) => LoginCubit())
            ],
            child: state.isSignedIn ?MainScreen() :LoginPage()
          );
        })
      )
    );
  }
}

