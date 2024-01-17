import 'package:bookurtreat_dev/firebase_options.dart';
import 'package:bookurtreat_dev/pages/flutter_env/flutter_env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  DotEnv dotenv = DotEnv();
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final titleText = dotenv.env['ENVIRONMENT'];
    return MaterialApp(
      debugShowCheckedModeBanner: isDebug(titleText ?? ''),
      title: 'Open Street Maps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Env(title: '$titleText'),
    );
  }

  bool isDebug(String environment) {
    if (environment.toLowerCase().trim() == 'staging') {
      return true;
    }
    if (environment.toLowerCase().trim() == 'production') {
      return false;
    }
    return true;
  }
}
