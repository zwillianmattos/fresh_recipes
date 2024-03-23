import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/data/services/account/auth/auth_service.dart';
import 'package:fresh_recipes/src/domain/services/auth_service.dart';
import 'package:fresh_recipes/src/presentation/modules/account/auth/login_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/account/auth/login_page.dart';
import 'package:fresh_recipes/src/usecases/account/do_login_use_case.dart';

class AuthModule extends Module {
  @override
  void binds(i) async {
    i.addInstance<AuthService>(AuthServiceImpl(i.get()));
    i.addSingleton(DoLoginUseCase.new);
    i.addSingleton(LoginPageController.new);
  }

  @override
  void routes(r) {
    r.child('/login', child: (_) => const LoginPage());
  }
}
