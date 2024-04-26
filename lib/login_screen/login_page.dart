import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manager/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  horizontal: 6,
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
                        TextFormField(
                          // validator: validateLoginPass,
                          keyboardType: TextInputType.text,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Colors.black45,
                          // obscureText: !_passwordVisible,
                          style: TextStyle(
                              color: Colors.black45, fontSize: 18),
                          // controller: model.passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black26)),
                            // prefixIcon: Container(
                            //   padding: EdgeInsets.all(15),
                            //   child: SvgPicture.asset(
                            //     'assets/images/lock_icon.svg',
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // suffixIcon: IconButton(
                            //   icon: Icon(
                            //     // _passwordVisible
                            //     //     ? Icons.visibility
                            //     //     :
                            //     Icons.visibility_off,
                            //     color: Colors.white,
                            //   ),
                            //   onPressed: () {
                            //     setState(() {
                            //       // _passwordVisible = !_passwordVisible;
                            //     });
                            //   },
                            // ),
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: "Email",
                            hintStyle:
                            const TextStyle(color: Colors.black45),
                          ),
                        ),
                        // TextFormField(
                        //   textAlignVertical: TextAlignVertical.center,
                        //   cursorColor: Colors.white,
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 18),
                        //   // controller: model.usernameController,
                        //   // validator: validateUsername,
                        //   decoration: InputDecoration(
                        //       enabledBorder: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(15),
                        //           borderSide: BorderSide(
                        //               width: 1, color: Colors.white),
                        //       ),
                        //       prefixIcon: Container(
                        //         padding: EdgeInsets.all(15),
                        //         // child: SvgPicture.asset(
                        //         //   'assets/images/profile_icon.svg',
                        //         //   color: Colors.white,
                        //         // ),
                        //       ),
                        //     fillColor: Colors.black45,
                        //     filled: true,
                        //     hintText: "Password",
                        //     hintStyle:
                        //     const TextStyle(color: Colors.white),
                        // )),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          // validator: validateLoginPass,
                          keyboardType: TextInputType.text,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Colors.black45,
                          // obscureText: !_passwordVisible,
                          style: TextStyle(
                              color: Colors.black45, fontSize: 18),
                          // controller: model.passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.black45)),
                            // prefixIcon: Container(
                            //   padding: EdgeInsets.all(15),
                            //   child: SvgPicture.asset(
                            //     'assets/images/lock_icon.svg',
                            //     color: Colors.white,
                            //   ),
                            // ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // _passwordVisible
                                //     ? Icons.visibility
                                //     :
                                Icons.visibility_off,
                                color: Colors.black45,
                              ),
                              onPressed: () {
                                setState(() {
                                  // _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: "Password",
                            hintStyle:
                            const TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // Routers.pushNamed(context, '/reset_password');
                          },
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        // loading
                        //     ? ProgressBar()
                        //     :
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const HomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              primary: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 36, vertical: 2),
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          child: Text("Login", style: TextStyle(
                            color: Colors.white,
                          )),
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
