
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:rapport_app/services/authentication.dart';
import 'package:rapport_app/views/screens/splash_wrapper_view.dart';

import 'config/constant.dart';
import 'config/rooting.dart';
import 'memory/preference.dart';
import 'models/app_user.dart';

void main() async {
  //initialisation de firebase
  WidgetsFlutterBinding.ensureInitialized();
  //initialisation de Firebase
  await Firebase.initializeApp();
  //on initialise les préférences dans l'app avant son lancement
  await UserSimplePreference.init();

  //exécution de l'app
  runApp(MyApp());
  //on prepare les progress dans l'app
  configLoading();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        onGenerateRoute: (settings)=>RouteGenerator.generateRoute(settings), //ensemble des routes
        initialRoute: '/',
        debugShowCheckedModeBanner: false, //c'est pour enlever le label debug
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: SplashWrapperView(),
        builder: EasyLoading.init(), //initialiser globalement ce progress
      ),
    );
  }
}

