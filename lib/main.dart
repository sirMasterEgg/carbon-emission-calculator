import 'package:dicoding/home.dart';
import 'package:dicoding/selected_menu.dart';
import 'package:dicoding/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicoding',
      debugShowCheckedModeBanner: false,
      theme: SimpleTheme.lightTheme,
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => const Home(),
        SelectedMenu.routeName: (context) => SelectedMenu(ModalRoute.of(context)?.settings.arguments as int),
      },
    );
  }
}