import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fresh_recipes/src/data/models/account/auth/login_dto.dart';
import 'package:fresh_recipes/src/domain/entities/account.dart';
import 'package:fresh_recipes/src/usecases/account/do_login_use_case.dart';
import 'package:uno/uno.dart';

class LoginPageController extends ValueNotifier<SignInState> {
  final DoLoginUseCase doLogin;
  LoginPageController(this.doLogin) : super(SignInInitialState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      value = SignInLoadingState();
      final loginRequest = LoginDto(
        emailController.text,
        passwordController.text,
      );
      Account account = await doLogin.call(loginRequest);
      value = SignInSuccessState(account);
    } on Exception catch (e) {
      String message = e.toString();
      if (e is UnoError) {
        if (e.message != '') {
          message = e.message;
        } else if (e.response?.data['message'] != '') {
          message = e.response?.data['message'];
        } else {
          message = 'Internal Server Error';
        }
      }
      value = SignInErrorState(message);
    }
  }

  String? validateEmail(String? value) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

    if (value == '') {
      return 'O campo de email não pode ser vazio.';
    } else if (!emailRegex.hasMatch(value!)) {
      return 'Insira um email válido.';
    } else if (value.toLowerCase().contains('spam')) {
      return 'O email não pode conter a palavra "spam".';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == '') {
      return 'O campo de senha não pode ser vazio.';
    } else if (value!.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }
    return null;
  }
}

abstract class SignInState extends Disposable {}

class SignInInitialState extends SignInState {
  @override
  void dispose() {}
}

class SignInLoadingState extends SignInState {
  @override
  void dispose() {}
}

class SignInSuccessState extends SignInState {
  final Account account;

  SignInSuccessState(this.account);

  @override
  void dispose() {}
}

class SignInErrorState extends SignInState {
  final String errorMessage;

  SignInErrorState(this.errorMessage);

  @override
  void dispose() {}
}
