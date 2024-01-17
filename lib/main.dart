import 'package:flutter/material.dart';
import 'package:photo_gallery/presentation/pages/gallery.dart';
void main() {
  // Set the screen orientation to portrait
  
    runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GalleryPage(),
    );
  }
}
