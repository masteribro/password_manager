import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_manager/component%20/button.dart';
import 'package:password_manager/component%20/text_field_widget.dart';
import 'package:password_manager/home_page/home_page.dart';
import '../registration_page/registration_page.dart';
import '../utills/local_storage.dart';
import '../utills/secure_storage.dart';

///Global variables
String? userEmail;
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {



  @override
  void initState()  {
    fetchFromStorage();
    super.initState();
  }
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
                            hintText: emailOrNumber ?? "Email"),
                        SizedBox(
                          height: 20,
                        ),
                       TextFieldWidget(
                           controller: passwordController,
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
                        const SizedBox(
                          height: 30,
                        ),




                       Row(
                         children: [
                           Expanded(
                             flex: 19,
                             child: SubmitButton(
                                 isLoading: false,
                                 label: "Submit",
                                 labelColor: Colors.white,
                                 submit: () {
                                   signIn(context,  email: emailOrNumber);                                 },
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
                                 loginWithBiometrics(context);
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationPage()));

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

  /// Declare all variables here
  bool passwordVisible = true;
  TextEditingController emailController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();

  /// This function is used to sign in the user
  Future<void> signIn(context, {password, email}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email ?? emailController.text ,
        password: password ?? passwordController.text,
      ).then((value) {
        if (value.user != null) {
          /// Getting the email of the user so that we can use it in the home page
          userEmail = value.user?.email;
          /// Save email and password in secure storage so that we can use it
          /// to login when using biometrics
          SecureStorage.save("emailOrNumberController", email ?? emailController.text);
          SecureStorage.save("passwordController", password ?? passwordController.text);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      });
    } catch (e) {
      // Handle sign-in errors
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              'There is an error while signing in. $e')));
    }
  }

  /// This function is used to toggle the visibility of the password
 void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
    debugPrint("passwordVisible: $passwordVisible");
  }

  /// This function is used to login with biometrics
  Future<void> loginWithBiometrics(context) async {
    final LocalAuthentication localAuth = LocalAuthentication();
    String? passwordText = await SecureStorage.fetch("ksPasswordController");
    try {
      // Check if biometrics are available
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      debugPrint('Can check biometrics: $canCheckBiometrics');

      if (canCheckBiometrics) {
        // Authenticate user with biometrics
        bool didAuthenticate = await localAuth.authenticate(
            localizedReason:
            'Authenticate to access the app', // Displayed to the user
            options: const AuthenticationOptions(
              biometricOnly: true,
              useErrorDialogs: true,
              stickyAuth: true,
            ));

        // If true, authentication will keep showing until the user cancels it

        if (didAuthenticate) {
          // Authentication successful, proceed with your app logic
          if(password != null && password != null){
            signIn(context, password: password, email: emailOrNumber);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(
                  'You can only utilize biometrics for authentication after your initial login with email and password, starting from the second attempt.')),
            );
          }
          debugPrint('Authentication successful');
        } else {
          // Authentication failed or canceled by the user
          debugPrint('Authentication failed or canceled');
        }
      } else {
        // Biometrics are not available on this device
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              'This device does not support biometrics authentication.')),
        );
        debugPrint('Biometrics not available');
      }
    } catch (e) {
      // Handle any exceptions
      debugPrint('Error: $e');
    }
  }

  /// This function is used to fetch the data from the secure storage
  Future<void> fetchFromStorage() async {
    emailOrNumber = await SecureStorage.fetch("emailOrNumberController");
    password = await SecureStorage.fetch("passwordController");
    biometric = await LocalStorage().fetch("biometrics") ?? false;
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
