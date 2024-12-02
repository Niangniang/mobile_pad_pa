import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/components/inputs/usernameTextField.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';
import 'package:provider/provider.dart';
import '../../components/button/ButtonLogin.dart';
import '../../components/button/textButonApp.dart';
import '../../components/inputs/passwordTextField.dart';
import '../../constantes/codeColors/codeColors.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _userLoginFormKey = GlobalKey<FormState>();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  bool isLoading = false; // Add isLoading state
  bool obscureText = false;
  Timer? _timer;

  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    // Annule le timer si il existe
    _timer?.cancel();
    telephoneController.dispose();
    pswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor:
          Colors.transparent, // Pour permettre l'image en arrière-plan
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/signIn_background.png',
              fit: BoxFit.cover, // L'image couvre tout l'écran
            ),
          ),
          // Contenu principal
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 420.0),
                  Form(
                    key: _userLoginFormKey,
                    child: Column(
                      children: [
                        UsernameTextField(
                          label: "",
                          hintText: "Téléphone ou Email",
                          controller: telephoneController,
                        ),
                        PasswordTextField(
                          label: "",
                          hintText: "Mot de passe",
                          controller: pswdController,
                          showPassword: showPassword,
                          obscureText: obscureText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButtonApp(
                              text: "mot de passe oublié",
                              onTap: () {},
                              txtStyle: TypoStyle.textLabelStyleS14W400CBlack,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        ButtonLogin(
                          text: "Se connecter",
                          onTap: () {
                            if (_userLoginFormKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });

                              authProvider.loginUser(
                                  username: telephoneController.text,
                                  password: pswdController.text,
                                  context: context);

                              _timer = Timer(const Duration(seconds: 2), () {
                                if (mounted) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            }
                          },
                          btnSize: const Size(double.infinity, 44),
                          colorbtn: GlobalColors.primaryColor,
                          isLoad: isLoading,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Vous avez un compte ?"),
                            TextButtonApp(
                              text: "S'inscrire",
                              onTap: () => context.go("/signUp"),
                              txtStyle:
                                  TypoStyle.textLabelStyleS16W500CNextonbording,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
