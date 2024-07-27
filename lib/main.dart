import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partidospoliticos/configuration/firebase_options.dart';
import 'package:partidospoliticos/login/login_user.dart';
import 'package:partidospoliticos/login/register_user.dart';
import 'package:partidospoliticos/pages/stream_votos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: LoginUser(),
    debugShowCheckedModeBanner: false,
  ));
}
