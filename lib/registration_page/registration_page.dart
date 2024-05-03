import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/component%20/button.dart';
import 'package:password_manager/component%20/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:password_manager/login_screen/login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  TextEditingController registrationEmailController =  TextEditingController();
  TextEditingController registrationPasswordController =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _showBackDialog();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              //  autovalidateMode: AutovalidateMode.onUserInteraction,
              // key: model.loginFormKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child:
                   Text(
                     "P",
                     style: TextStyle(
                       color: Colors.green,
                       fontWeight: FontWeight.bold,
                       fontSize: 100,
                     ),
                   ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Resgistration",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'sofiapro-light'),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 50,
                    child:  Text(
                      "Please enter your account details",
                      style: TextStyle(
                        color: Colors.green.shade200,
                        fontSize: 15,
                        fontFamily: 'sofiapro',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    //  margin: EdgeInsets.only(right: 35, left: 35),
                    child: Column(
                      children: [
                        TextFieldWidget(
                            controller: registrationEmailController,
                            textInputType: TextInputType.text,
                            hintText: "Email"),
                        SizedBox(
                          height: 20,
                        ),
                       // TextFieldWidget(
                       //     controller: registrationPasswordController,
                       //     hintText: "Password",
                       //     textInputType: TextInputType.text),

                        TextFieldWidget(
                          controller: registrationPasswordController,
                          hintText: "Password",
                          obscureText: true,
                          isPasswordField: passwordVisible ,
                          textInputType: TextInputType.text,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              togglePassword();
                            },
                            child:  passwordVisible ?Icon(
                                Icons.visibility_off_outlined
                            ) : Icon(Icons.visibility_outlined),
                          ),

                        ),
                        SizedBox(
                          height: 30,
                        ),




                       SubmitButton(
                           isLoading: false,
                           label: "Submit",
                           labelColor: Colors.white,
                           submit: () {
                             signUp(context);
                           },
                           color: Colors.green),

                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                                  "Dont have any account?",
                                  style: TextStyle(
                                      color: Colors.black45, fontSize: 16),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                },
                                child: (
                                    const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Declare all variable
  bool passwordVisible = true;

  /// This function is used to show a dialog when the user presses the back button on this screen
  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave the app?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                exitApp();
              },
            ),
          ],
        );
      },
    );
  }

  /// This function is used to exit the app when the user presses the back button
   void  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  /// Sign up with email and password
  Future<void> signUp(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: registrationEmailController.text,
        password: registrationPasswordController.text,
      ).then((value) {
        if (value.user != null) {
          ///This navigate you to the login page after signing up
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));

          /// This shows a snack-bar(pop-up) to the user that the account was created successfully
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(
                'Account created successfully')),
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              '$e')));

    }
  }

  /// This function is used to toggle the visibility of the password
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
    debugPrint("passwordVisible: $passwordVisible");
  }

}
