import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env extends StatelessWidget {
  Env({super.key, required this.title});
  final String? apiUrl = dotenv.env['API_URL'];
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${title.toUpperCase()}"),
      ),
      body: Center(
        child: Text(
          'API_URL: $apiUrl',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
