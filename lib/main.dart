import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:realtimedatabase/realtime.dart';
import 'package:realtimedatabase/viewdata.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
  runApp(MaterialApp(home: viewdata(),));
}