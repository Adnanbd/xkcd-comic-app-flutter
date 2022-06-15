import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd/Controller/Providers/all_comic_provider.dart';
import 'package:xkcd/Controller/Providers/saved_comic_provider.dart';
import 'package:xkcd/View/Screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllComicProvider()),
        ChangeNotifierProvider(create: (_) => SavedComicProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XKCD Comic App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
