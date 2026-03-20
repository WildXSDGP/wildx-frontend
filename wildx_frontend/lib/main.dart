import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens සහ Themes imports 
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, 
    ),
  );

  runApp(const WildXApp());
}

class WildXApp extends StatelessWidget {
  const WildXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildX',
      debugShowCheckedModeBanner: false,
      
      theme: AppTheme.light, 
      
    
      home: const LoginScreen(), 
    );
  }
}