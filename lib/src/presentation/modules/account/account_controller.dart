import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/domain/entities/recipe.dart';
import 'package:fresh_recipes/src/usecases/account/do_logout_use_case.dart';
import 'package:fresh_recipes/src/usecases/account/get_my_profile_use_case.dart';

class AccountPageController extends Disposable {
  final GetMyProfileUseCase profileUseCase;
  final DoLogoutUseCase doLogoutUseCase;

  final AccountPageState state = AccountPageState();

  AccountPageController(this.profileUseCase, this.doLogoutUseCase) {
    getProfile();
  }

  getProfile() async {
    try {
      state.loadingNotifier.value = true;
      state.dataNotifier.value = await profileUseCase.call();
    } catch (e) {
      state.errorNotifier.value = e.toString();
    } finally {
      state.loadingNotifier.value = false;
    }
  }

  logOut() {
    doLogoutUseCase.call();
  }

  @override
  void dispose() {}
}

class AccountPageState {
  final ValueNotifier<bool> loadingNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<List<Recipe>> recipes = ValueNotifier<List<Recipe>>([]);
  final ValueNotifier<Account> dataNotifier = ValueNotifier<Account>(Account());
}
