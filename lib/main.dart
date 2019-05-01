import 'package:flutter/material.dart';
import 'package:youtube_search/injection_container.dart';
import 'package:youtube_search/ui/search/search_page.dart';

void main() {
  initKiwi();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red.shade600,
          accentColor: Colors.redAccent.shade400,
        ),
        home: SearchPage());
  }
}
