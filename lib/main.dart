import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCQsKU8Rkw__ZhLrO9khKBLEpqILJ-o91I",
        authDomain: "language-learning-app-proj.firebaseapp.com",
        projectId: "language-learning-app-proj",
        storageBucket: "language-learning-app-proj.firebasestorage.app",
        messagingSenderId: "727529063602",
        appId: "1:727529063602:web:e010421dd635fa842d75ab"));
  }else{
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Learning Assistant',
      home: AuthScreen(),
    );
  }
}

