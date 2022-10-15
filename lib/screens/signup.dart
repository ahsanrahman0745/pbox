import 'dart:async';
// 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:pbox/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pbox/provider/user_provider.dart';
import 'package:pbox/utils/assets.dart';
import 'list_of_fans.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

import 'loginscreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  late Timer timer;
  final _formKey = GlobalKey<FormState>();
  final UserNameEditingController = new TextEditingController();
  final NameEditingController = new TextEditingController();
  final PasswordEditingController = new TextEditingController();
  final EmailEditingController = new TextEditingController();
  final ContactEditingController = new TextEditingController();
  final RoleEditingController = new TextEditingController();
  bool isSignupScreen = true;
  bool isMale = true;
  late File? _pickedImage;
  bool selectedImage = false;
  late String ImgURL;

  @override
  Widget build(BuildContext context) {
    final UserNameField = TextFormField(
      autofocus: false,
      controller: UserNameEditingController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        UserNameEditingController.text = value!;
      },
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'UserName cannot be empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Enter UserName",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    final NameField = TextFormField(
      autofocus: false,
      controller: NameEditingController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        NameEditingController.text = value!;
      },
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Name cannot be empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Enter Name",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    final PasswordField = TextFormField(
      autofocus: false,
      controller: PasswordEditingController,
      obscureText: true,
      onSaved: (value) {
        PasswordEditingController.text = value!;
      },
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Password cannot be empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Enter Password",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    final EmailField = TextFormField(
      autofocus: false,
      controller: EmailEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        EmailEditingController.text = value!;
      },
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Email cannot be empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Enter Email",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    final ContactField = TextFormField(
      autofocus: false,
      controller: ContactEditingController,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        ContactEditingController.text = value!;
      },
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Contact Num cannot be empty';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Enter Contact Number",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    final RoleField = DropdownButtonFormField(
      hint: Text(
        'Please choose your Role',
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      items: <String>['Celebrity', 'Fan'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          RoleEditingController.text = value.toString();
        });
      },
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(10),
        hintText: "Select Role",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );

    final signupbutton = Material(
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // _verify_email();
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Verification Email has been send to you.')),
            // );
            // if (_formKey.currentState!.validate()) {
            _signupuser();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Creating Account')),
            );
          }
        },
        child: Text(
          'SIGN UP',
        ),
        style: TextButton.styleFrom(
            minimumSize: Size(300, 40),
            primary: Colors.white,
            backgroundColor: Colors.indigo),
      ),
    );

    final MaleField = GestureDetector(
      onTap: () {
        setState(() {
          isMale = true;
        });
      },
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            child: Icon(
              Icons.man,
              color: isMale ? Colors.pinkAccent : Colors.grey,
            ),
          ),
          Text(
            "Male",
            style: TextStyle(
              color: isMale ? Colors.pinkAccent : Colors.grey,
            ),
          )
        ],
      ),
    );

    final FemaleField = GestureDetector(
      onTap: () {
        setState(() {
          isMale = false;
        });
      },
      child: Row(
        children: [
          Container(
            width: 30, height: 30,
            //  margin: const EdgeInsets.only(right: 1),
            child: Icon(
              Icons.woman,
              color: isMale ? Colors.grey : Colors.pinkAccent,
            ),
          ),
          Text(
            "Female",
            style: TextStyle(
              color: isMale ? Colors.grey : Colors.pinkAccent,
            ),
          )
        ],
      ),
    );

    //File _PresentImage =  getImageFileFromAssets('assets/images/blank_profile.png') as File;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'SIGN UP',
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.pink, Colors.deepOrangeAccent]),
            ),
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        body: Stack(children: [
          Column(
            children: [
              Container(
                height: 200,
                color: Colors.black,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.16),
                      child: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Center(
                          child: IconButton(
                            icon: new Icon(Icons.camera_alt),
                            highlightColor: Colors.white,
                            onPressed: () {
                              _pickImageCamera();
                            },
                          ),
                        ),
                      ),
                      //backgroundImage: Icons.cloud_upload_rounded,
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.06,
                            bottom: MediaQuery.of(context).size.width * 0.06),
                        child: selectedImage
                            ? CircleAvatar(
                                backgroundImage: FileImage(_pickedImage!),
                                radius: 50,
                                backgroundColor: Colors.black,
                              )
                            : CircleAvatar(
                                radius: 50,
                                child: CircleAvatar(
                                  child: Image.asset(Assets.blank_profile),
                                  radius: 50,
                                  backgroundColor: Colors.black,
                                ),
                              )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.08),
                      child: CircleAvatar(
                        backgroundColor: Colors.deepOrangeAccent,
                        child: Center(
                          child: IconButton(
                            icon: new Icon(Icons.photo),
                            highlightColor: Colors.white,
                            onPressed: () {
                              _pickImageGallery();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              top: 150,
              child: Container(
                  height: 482,
                  width: MediaQuery.of(context).size.width - 40.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5),
                      ]),
                  child: Column(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 20.0,
                              left: 20.0,
                              right: 20.0,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        UserNameField,
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: NameField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: PasswordField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: EmailField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: ContactField,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: Container(
                                            height: 49,
                                            width: 500,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  '  Gender              ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                                MaleField,
                                                FemaleField,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          child: RoleField,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                signupbutton,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]))),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      child: Text(
                        'Sign In',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.transparent),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                Login()));
                      },
                    ),
                  ],
                ),
              ]),
        ]));
  }

  Future _signupuser() async {
    try {
      if (_pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please pick an Image')),
        );
        //_globalMethods.authErrorHandle(Future.error("please pick an image"),context);
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child("UserImages")
            .child(UserNameEditingController.text + ".jpg");
        await ref.putFile(_pickedImage as File);
        ImgURL = await ref.getDownloadURL();

        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: EmailEditingController.text,
                password: PasswordEditingController.text)
            .then((value) {
          if (RoleEditingController.text == "Fan") {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    HomeScreen(email: EmailEditingController.text)));
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FanList(artistemail: EmailEditingController.text)));
          }

          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Verification Email has been sent to you.')),
          // );
          // _verify_email();
        });

        Map<String, dynamic> Users = {
          "UserName": UserNameEditingController.text,
          "Name": NameEditingController.text,
          "Email": EmailEditingController.text,
          "Password": PasswordEditingController.text,
          "Contact": ContactEditingController.text,
          "Role": RoleEditingController.text,
          "star": 0,
          "Gender": isMale ? "Male" : "Female",
          "ImageURL": ImgURL,
        };

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(UserNameEditingController.text)
            .set(Users)
            .whenComplete(() {
          print("$UserNameEditingController.text created");
        });
      }
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return "This Email ID already Associated with Another Account.";
        }
      }
    }
  }

  Future _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      selectedImage = true;
      _pickedImage = pickedImageFile;
    });
    //Navigator.pop(context);
  }

  Future _pickImageGallery() async {
    final navigator = Navigator.of(context);
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    print('$pickedImageFile');
    setState(() {
      selectedImage = true;
      _pickedImage = pickedImageFile;
    });
    if (pickedImage != null) {
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      //   return SignupScreen();
      // }));

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>SignupScreen() ,));

      //Navigator.pop(context);
    }
  }

  // Future<File> getImageFileFromAssets(String path) async {
  //   final byteData = await rootBundle.load('assets/$path');
  //
  //   final file = File('${(await getTemporaryDirectory()).path}/$path');
  //   await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  //
  //   return file;
  // }
  //
  // Future<Directory> getApplicationDocumentsDirectory() async {
  //   final String? path = Assets.blank_profile;
  //   return Directory(path!);
  // }
  //
  // Future<File>  _getLocalFile(String _presentImage) async {
  //   final root = await await getApplicationDocumentsDirectory();
  //   final path =  _presentImage;
  //   return File(path).create(recursive: true);
  // }
  //
  // void _verify_email() async{
  //
  //     void initState(){
  //       if(user != null)
  //       {
  //         user= auth.currentUser;
  //         user?.sendEmailVerification();
  //
  //         timer = Timer.periodic(Duration(seconds: 5),(timer){
  //
  //         });
  //       }
  //     }
  //      super.initState();
  // }
  //
  // Future<void> checkEmailVerified() async{
  //   user = auth.currentUser;
  //   await user!.reload();
  //   if(user!.emailVerified){
  //     timer.cancel();
  //     _signupuser();
  //     //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
  //   }
  //   else{
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Email Account doesnot exist')),
  //     );
  //   }
  // }

}
