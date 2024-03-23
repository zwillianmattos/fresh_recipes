import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/data/datasources/local_storage.dart';
import 'package:fresh_recipes/src/presentation/modules/account/auth/auth_module.dart';
import 'package:fresh_recipes/src/presentation/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:uno/uno.dart';

class AppModule extends Module {
  @override
  void binds(i) async {
    i.add<Uno>(unoFactory);
  }

  @override
  void routes(r) {
    r.module(Modular.initialRoute, module: BottomNavigationModule(), guards: [
      AuthGuard()
    ]);
    r.module('/auth', module: AuthModule());
  }
}

Uno unoFactory() {
  return Uno(
    baseURL: "https://zgbkslp9-3000.brs.devtunnels.ms",
    timeout: const Duration(seconds: 10),
  );
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/login');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    String accountToken = await LocalStorage.getValue<String>('account_token');
    return accountToken != "";
  }
}
