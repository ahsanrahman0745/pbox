// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pbox/utils/assets.dart';

class ChangePassword extends StatelessWidget {
  final String email;
  ChangePassword({Key? key, required this.email}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final EmailEditingController = new TextEditingController();
  final PasswordEditingController = new TextEditingController();
  final ConfirmPasswordEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> ustream = FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: email)
        .snapshots();
    final List userdata = [];

    Future ChangePassword(UserName) async{
      try {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(UserName)
            .update({
          "Password": PasswordEditingController.text,
        });

        Map<String, dynamic> History = {
          "email": email,
          "activity": "You Changed your Password",
        };

        await FirebaseFirestore.instance
            .collection("History")
            .doc()
            .set(History)
            .whenComplete(() {
          print("$email.History created");
        });
      } catch (e) {
        print(e);
      }
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.loginBackground),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'PBOX',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white)),
                        suffix: Icon(Icons.question_mark),
                        labelText: 'Enter your email ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        fillColor: Colors.redAccent,
                        filled: true,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 64, 199, 23),
                            fontSize: 15),
                      ),
                      controller: EmailEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        else if (email != EmailEditingController.text) {
                          return 'Email doesnot match your current Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white)),
                        suffix: Icon(Icons.question_mark),
                        labelText: 'Enter your New Password ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        fillColor: Colors.redAccent,
                        filled: true,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 64, 199, 23),
                            fontSize: 15),
                      ),
                      controller: PasswordEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter New Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02),
                    child: TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(width: 1, color: Colors.white)),
                        suffix: Icon(Icons.question_mark),
                        labelText: 'Confirm New Password',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        fillColor: Colors.redAccent,
                        filled: true,
                        errorStyle: TextStyle(
                            color: Color.fromARGB(255, 64, 199, 23),
                            fontSize: 15),
                      ),
                      controller: ConfirmPasswordEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Confirm Password';
                        }
                        else if (PasswordEditingController.text != ConfirmPasswordEditingController.text) {
                          return 'Passwords donot match';
                        }
                        return null;
                      },
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                  stream: ustream,
                  builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                  return Center(
                  child: CircularProgressIndicator(),
                  );
                  }

                  snapshot.data!.docs.map((DocumentSnapshot e) {
                  Map dis = e.data() as Map<String, dynamic>;
                  userdata.add(dis);
                  }).toList();
                  return Padding(
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.03),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size(MediaQuery.of(context).size.height, 50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if(email == EmailEditingController.text && PasswordEditingController.text == ConfirmPasswordEditingController.text){
                            String UserName = userdata[0]['UserName'];
                            ChangePassword(UserName);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orangeAccent,
                                content: Text(
                                  "Password Changed",
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                ),
                              ),
                            );
                          }
                        }
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  );})
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
