import 'package:uno/uno.dart';

Uno unoFactory() {
  return Uno(
    baseURL: "https://zgbkslp9-3000.brs.devtunnels.ms",
    timeout: const Duration(seconds: 10),
  );
}
