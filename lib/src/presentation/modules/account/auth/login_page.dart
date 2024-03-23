import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_recipes/src/presentation/modules/account/auth/login_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginPageController _controller = Modular.get<LoginPageController>();

  @override
  void initState() {
    super.initState();
  }

  signIn() async {
    if (_controller.formKey.currentState?.validate() == false) return;
    await _controller.login();
    if (_controller.value is SignInSuccessState) {
      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          title: 'Login Successfuly',
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 1),
          borderRadius: BorderRadius.circular(100.0),
          boxShadow: lowModeShadow,
        );
      }
      Modular.to.pushReplacementNamed('/');
    } else if (_controller.value is SignInErrorState) {
      final errorState = _controller.value as SignInErrorState;
      if (context.mounted) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          title: errorState.errorMessage,
          alignment: Alignment.bottomCenter,
          boxShadow: lowModeShadow,
          showProgressBar: false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder<SignInState>(
        valueListenable: _controller,
        builder: (context, signInState, child) {
          return buildSignInForm(context, signInState);
        },
      ),
    );
  }

  Widget buildSignInForm(BuildContext context, SignInState signInState) {
    bool isLoading = signInState is SignInLoadingState;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              'assets/img/refitness.png',
              height: 40,
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Entrar",
                        style: GoogleFonts.quicksand(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Insira seus dados para continuar.",
                        style: GoogleFonts.quicksand(fontSize: 18, color: const Color(0xFF737373)),
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                FreshTextField(enabled: !isLoading, controller: _controller.emailController, hintText: 'Email', validator: _controller.validateEmail, textInputAction: TextInputAction.next, keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16.0),
                FreshTextField(
                  enabled: !isLoading,
                  controller: _controller.passwordController,
                  obscureText: true,
                  hintText: 'Password',
                  validator: _controller.validatePassword,
                  textInputAction: TextInputAction.send,
                  keyboardType: TextInputType.visiblePassword,
                  onFieldSubmitted: (value) => signIn(),
                ),
                const SizedBox(height: 16.0),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                        onPressed: !isLoading ? () => signIn() : null,
                        style: TextButton.styleFrom(
                          backgroundColor: isLoading ? Colors.green.withOpacity(.8) : Colors.green,
                          padding: const EdgeInsets.all(16.0),
                        ),
                        child: isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : Text(
                                'Login',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextButton(
                      onPressed: () {
                        Modular.to.pushNamed('/auth/recovery');
                      },
                      child: Text(
                        "Esqueceu a senha ?",
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: const Color(0xFF737373),
                          decoration: TextDecoration.underline,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Divider(
                          thickness: 1.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "ou",
                          style: GoogleFonts.quicksand(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.green,
                      primary: Colors.white,
                    ),
                    textTheme: GoogleFonts.sourceSans3TextTheme(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: !isLoading ? () => signIn() : null,
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xffDF4A32),
                            disabledBackgroundColor: const Color(0xffDF4A32).withOpacity(.8),
                            padding: const EdgeInsets.all(16.0),
                          ),
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: !isLoading ? () => signIn() : null,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff39579A),
                            disabledBackgroundColor: const Color(0xff39579A).withOpacity(.8),
                            padding: const EdgeInsets.all(16.0),
                          ),
                          icon: const Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: !isLoading ? () => signIn() : null,
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff000000),
                            disabledBackgroundColor: const Color(0xff000000).withOpacity(.8),
                            padding: const EdgeInsets.all(16.0),
                          ),
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
