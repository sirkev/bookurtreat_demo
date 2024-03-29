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
        backgroundColor: getColor(title),
        title: Text(title.toUpperCase()),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'built from : $title environment',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'API url value: $apiUrl',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(String environment) {
    if (environment.toLowerCase().trim() == 'staging') {
      return Colors.amberAccent;
    }
    if (environment.toLowerCase().trim() == 'production') {
      return Colors.green;
    }
    return Colors.red;
  }
}
