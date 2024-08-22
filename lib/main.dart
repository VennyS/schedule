import 'package:flutter/material.dart';
import 'package:package_user/package_user.dart';
import 'package:schedule/gto_page.dart';

import 'api/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.load();
  final apiService = ApiService(Config.baseUrl);
  runApp(MyApp(apiService: apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  const MyApp({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: MyCalendar(
          apiService: apiService,
          gtoPageBuilder: (item) => GtoPage(item: item),
        ),
      ),
    );
  }
}
