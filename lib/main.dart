import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/presentation/app_module.dart';
import 'package:fresh_recipes/src/presentation/app_widget.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks([
      'google_fonts'
    ], license);
  });
  runApp(
    ModularApp(
      module: AppModule(),
      debugMode: true,
      child: const FreshRecipesApp(),
    ),
  );
}
