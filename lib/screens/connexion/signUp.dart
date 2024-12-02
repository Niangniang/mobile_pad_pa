import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_pad_pa/constantes/textStyles/textStyle.dart';
import '../../components/button/customButton.dart';
import '../../components/button/textButonApp.dart';
import '../../components/inputs/emailTextField.dart';
import '../../components/inputs/myTextField.dart';
import '../../components/inputs/passwordTextField.dart';
import '../../components/inputs/phoneTextField.dart';
import '../../constantes/codeColors/codeColors.dart';
import 'package:provider/provider.dart';
import 'package:mobile_pad_pa/providers/provider_authentification/provider_authentification.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MaterialApp(
        home: SignUp(), // Assurez-vous que SignUp est importé correctement
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {

   AuthProvider authUser = AuthProvider();


  final _userRegisterFormKey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  TextEditingController confpswdController = TextEditingController();
  //bool isLoading = false; // Add isLoading state
  bool obscureText = false;
  void showPassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    telephoneController.dispose();
    pswdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: 960,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/signUp_background.png'),
              fit: BoxFit.cover, // pour que l'image couvre tout l'écran
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100.0, left: 32.0, right: 32.0, bottom: 32.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Inscription",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Form(
                    key: _userRegisterFormKey,
                    child: Column(
                      children: [
                        MyTextField(
                          label: "",
                          hintText: "Nom",
                          controller: nomController,
                        ),
                        MyTextField(
                          label: "",
                          hintText: "Prenom",
                          controller: prenomController,
                        ),
                        EmailTextFormField(
                          label: "",
                          hintText: "Email",
                          controller: emailController,
                        ),
                        PhoneTextField(
                          label: "",
                          hintText: "Téléphone",
                          controller: telephoneController,
                        ),
                        PasswordTextField(
                          label: "",
                          hintText: "Mot de passe",
                          controller: pswdController,
                          showPassword: showPassword,
                          obscureText: obscureText,
                        ),
                        PasswordTextField(
                          label: "",
                          hintText: "Confirmer le mot de passe",
                          controller: confpswdController,
                          showPassword: showPassword,
                          obscureText: obscureText,
                        ),
                        const SizedBox(height: 32.0),
                        CustomButton(
                          text: "Inscription",
                          onTap: () {
                            Map<String, dynamic> data = {
                              "prenom": prenomController.text,
                              "nom": nomController.text,
                              "telephone": telephoneController.text,
                              "email": emailController.text,
                              "password": pswdController.text,
                              "adresse": "Mbour"
                            };
                            if (_userRegisterFormKey.currentState!
                                  .validate()) {
                              debugPrint('Je suis lancé ===================');
                                authUser.registerUser(user: data, context: context);
                              }
                          },
                          btnSize: const Size(double.infinity, 44),
                          colorbtn: GlobalColors.primaryColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Vous avez un compte ?"),
                            TextButtonApp(
                                text: "Se connecter",
                                onTap: () => context.go("/signIn"),
                                txtStyle: TypoStyle
                                    .textLabelStyleS16W500CNextonbording)
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
