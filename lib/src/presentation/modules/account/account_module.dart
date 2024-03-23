import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/presentation/modules/account/account_controller.dart';
import 'package:fresh_recipes/src/presentation/modules/account/account_page.dart';
import 'package:fresh_recipes/src/usecases/account/do_logout_use_case.dart';
import 'package:fresh_recipes/src/usecases/account/get_my_profile_use_case.dart';
import 'package:fresh_recipes/src/usecases/account/get_profile_recipes_use_case.dart';

class AccountModule extends Module {
  @override
  void binds(i) async {
    i.addInstance(DoLogoutUseCase());
    i.addInstance(GetMyProfileUseCase(i.get()));
    i.addInstance(GetMyProfileRecipesUseCase(i.get()));
    i.addSingleton(AccountPageController.new);
  }

  @override
  void routes(r) {
    r.child('/profile', child: (_) => const AccountPage());
  }
}
