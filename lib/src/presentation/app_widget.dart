import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class FreshRecipesApp extends StatelessWidget {
  const FreshRecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fresh Recipes',
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        textTheme: GoogleFonts.sourceSans3TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
