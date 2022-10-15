// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, prefer_const_constructors_in_immutables, library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pbox/screens/forgetpass.dart';
import 'package:pbox/screens/home_screen.dart';
import 'package:pbox/screens/signup.dart';

import '../utils/assets.dart';
import 'list_of_fans.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  List userdata = [];

  //  Login(userrole) async{
  //
  //   if(userrole[0]['Role'] == "Fan")
  //   {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => HomeScreen(
  //           email: email,
  //         ),
  //       ),
  //     );
  //   }
  //   else{
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => FanList(
  //           artistemail: email,
  //         ),
  //       ),
  //     );
  //   }
  // }
  final FirebaseAuth auth = FirebaseAuth.instance;

  userLogin() async {
// new update
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = auth.currentUser;
      print("user1=> ${user?.email}");

      var responce = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.email).get().catchError((error) =>
      {print("Error on get data from User"), print(error.toString())});

      // .where("Email", isEqualTo: emailController.text)
          // .where("Password", isEqualTo: passwordController.text)
       //   .snapshots();
      //Login(userrole);
      if(responce.exists){
        Map<String, dynamic>? data = responce.data();
        print(' email of user=> ${data?["Email"]}');

      }



  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.loginBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PBOX',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white)),
                        suffix: Icon(Icons.mail),
                        labelText: 'Email ',
                        labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: Color.fromARGB(255, 255, 250, 250),
                        ),
                        border: OutlineInputBorder(),
                        fillColor: Colors.redAccent,
                        filled: true,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 19, 219, 46),
                            fontSize: 15),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.white)),
                        labelText: 'Password ',
                        labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 255, 250, 250)),
                        border: OutlineInputBorder(),
                        fillColor: Colors.redAccent,
                        filled: true,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 27, 216, 90),
                            fontSize: 15),
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 60.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                                password = passwordController.text;
                              });
                              userLogin();
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()),
                            )
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account? "),
                        TextButton(
                          onPressed: () => {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const SignupScreen(),
                              ),
                            )
                          },
                          child: Text('Signup'),
                        ),
                        // TextButton(
                        //   onPressed: () => {
                        //     Navigator.pushAndRemoveUntil(
                        //         context,
                        //         PageRouteBuilder(
                        //           pageBuilder: (context, a, b) => UserMain(),
                        //           transitionDuration: Duration(seconds: 0),
                        //         ),
                        //         (route) => false)
                        //   },
                        //   child: Text('Dashboard'),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
