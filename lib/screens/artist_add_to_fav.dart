// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pbox/utils/assets.dart';

class AddtoFavScreen extends StatefulWidget {
  const AddtoFavScreen({Key? key}) : super(key: key);

  @override
  State<AddtoFavScreen> createState() => _AddtoFavScreenState();
}

class _AddtoFavScreenState extends State<AddtoFavScreen> {
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _fbID = TextEditingController();
  final TextEditingController _igID = TextEditingController();
  final TextEditingController _twID = TextEditingController();
  final TextEditingController _favPlace = TextEditingController();
  final TextEditingController _favSong = TextEditingController();
  final TextEditingController _favMovie = TextEditingController();
  final TextEditingController _favCloth = TextEditingController();
  final TextEditingController _hobby = TextEditingController();
  final TextEditingController _productOfWeek = TextEditingController();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("Favorites");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xff2caefc),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: width,
                height: height / 14.34,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff2caefc),
                      Color(0xff17d6e0),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(height / 32.12),
                              bottomRight: Radius.circular(height / 32.12),
                            ),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height / 133.83,
                              horizontal: height / 80.3),
                          child: Row(
                            children: [
                              Icon(
                                Icons.keyboard_double_arrow_left,
                                color: Colors.white,
                              ),
                              Text(
                                "Back",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Text("ARTIST PROFILE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: height / 44.61)),
                    SizedBox(
                      child: Text("            "),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff17d6e0),
                        Color(0xff2caefc),
                      ],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: height / 4.01,
                          child: Image(
                            image: AssetImage(Assets.actor1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 9.25,
                        child: SizedBox(
                          width: width / 1.77,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(height / 80.3),
                                            topRight: Radius.circular(
                                                height / 80.3)))),
                                onPressed: () {},
                                child: Icon(Icons.file_copy),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.orange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(height / 80.3),
                                            topRight: Radius.circular(
                                                height / 80.3)))),
                                onPressed: () {},
                                child: Icon(Icons.photo),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft:
                                                Radius.circular(height / 80.3),
                                            topRight: Radius.circular(
                                                height / 80.3)))),
                                onPressed: () {},
                                child: Icon(Icons.videocam),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 5.74,
                        bottom: height / 80.3,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(height / 80.3),
                              color: Colors.white,
                            ),
                            width: width / 1.12,
                            child: Padding(
                              padding: EdgeInsets.all(height / 50.18),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    controller: _name,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _dob,
                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2019, 1, 1),
                                          lastDate: DateTime(2050, 12, 1),
                                          builder: (context, picker) {
                                            return Theme(
                                              data: ThemeData.dark().copyWith(
                                                colorScheme: ColorScheme.dark(
                                                  primary: Colors.white,
                                                  onPrimary: Colors.black,
                                                  surface: Colors.pink,
                                                  onSurface: Colors.yellow,
                                                ),
                                                dialogBackgroundColor:
                                                    Colors.black,
                                              ),
                                              child: picker!,
                                            );
                                          }).then((selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            _dob.text =
                                                "${selectedDate.toLocal()}"
                                                    .split(' ')[0];
                                          });
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist D.O.B",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _fbID,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Facebook ID",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _twID,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Twitter ID",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _igID,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Instagram ID",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _favPlace,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Favorite Place",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _favSong,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Favorite Song",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _favMovie,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Favorite Movie",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _hobby,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Hobbies",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _favCloth,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Favorite Clothing",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  TextFormField(
                                    controller: _productOfWeek,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0,
                                          horizontal: height / 53.53),
                                      hintText: "Artist Product of Week",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            height / 80.3),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height / 50.9),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff40639d),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              height / 80.3)),
                                      fixedSize: Size(
                                          double.maxFinite, height / 16.06),
                                    ),
                                    onPressed: () {
                                      final add = ActorFav(
                                          name: _name.text,
                                          dob: _dob.text,
                                          fb: _fbID.text,
                                          ig: _igID.text,
                                          tw: _twID.text,
                                          place: _favPlace.text,
                                          song: _favSong.text,
                                          movie: _favMovie.text,
                                          cloth: _favCloth.text,
                                          hobbie: _hobby.text,
                                          product: _productOfWeek.text);

                                      addtoFav(add);

                                      Fluttertoast.showToast(
                                          msg: "Added to Favorites",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.SNACKBAR,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    },
                                    child: Text(
                                      "ADD TO FAVORITIES",
                                      style:
                                          TextStyle(fontSize: height / 44.61),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addtoFav(ActorFav add) async {
    final json = add.toJson();
    await _reference.add(json);
  }
}

class ActorFav {
  final String name;
  final String dob;
  final String fb;
  final String ig;
  final String tw;
  final String place;
  final String song;
  final String movie;
  final String cloth;
  final String hobbie;
  final String product;
  ActorFav({
    required this.name,
    required this.dob,
    required this.fb,
    required this.ig,
    required this.tw,
    required this.place,
    required this.song,
    required this.movie,
    required this.cloth,
    required this.hobbie,
    required this.product,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob,
        "fb": fb,
        "ig": ig,
        "twitter": tw,
        "favplace": place,
        "favsong": song,
        "favmovie": movie,
        "favcloth": cloth,
        "hobby": hobbie,
        "product": product,
      };
}
