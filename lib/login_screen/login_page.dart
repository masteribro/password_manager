import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/component%20/button.dart';
import 'package:password_manager/component%20/text_field_widget.dart';
import 'package:password_manager/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
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
                      "Welcome!",
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
                            controller: emailController,
                            textInputType: TextInputType.text,
                            hintText: "Email"),
                        SizedBox(
                          height: 20,
                        ),
                       TextFieldWidget(
                           controller: passwordController,
                           hintText: "Password",
                           textInputType: TextInputType.text),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),


                       Row(
                         children: [
                           Expanded(
                             flex: 19,
                             child: SubmitButton(
                                 isLoading: false,
                                 label: "Submit",
                                 labelColor: Colors.white,
                                 submit: () {
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                                 },
                                 color: Colors.green),
                           ),
                           const Expanded(
                               flex: 1,
                               child: SizedBox(
                                 width: 5,
                               )),
                           Expanded(
                             flex: 4,
                             child: GestureDetector(
                               onTap: () {
                               },
                               child: Container(
                                 height: 62,
                                 width: 40,
                                 decoration: BoxDecoration(
                                   color: Colors.green,
                                   borderRadius: BorderRadius.circular(15),
                                 ),
                                 child: Icon(Icons.fingerprint_outlined,
                                     color: Colors.white),
                               ),
                             ),
                           )
                         ],
                       ),
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

                                },
                                child: (
                                    const Text(
                                  "Signup",
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
  exitApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }



}
