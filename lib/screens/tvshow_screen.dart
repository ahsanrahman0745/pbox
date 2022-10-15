// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pbox/screens/loginscreen.dart';
import 'package:pbox/screens/movie_screen.dart';
import 'package:pbox/screens/songs_screen.dart';
import 'package:pbox/screens/sports_screen.dart';
import '../utils/assets.dart';
import 'package:flutter/services.dart';

class TvShows extends StatefulWidget {
  const TvShows({Key? key}) : super(key: key);

  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(),
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.tvShowBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 610,
                right: 55,
                child: Center(
                  child: Text(
                    'To be closer to your celebrities ',
                    style: TextStyle(
                        color: Colors.white, wordSpacing: 2, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          color: Color.fromARGB(255, 233, 152, 3),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.tv,
                                color: Colors.white,
                              ),
                              Text(
                                "TV Shows",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        icon: Icon(
                          Icons.skip_next_sharp,
                          size: 30,
                          color: Colors.white,
                        ),
                        label: Text(
                          'skip',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -5,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Movies()));
                        },
                        child: Icon(Icons.movie_creation),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 207, 8, 8)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TvShows()));
                        },
                        child: Icon(Icons.tv),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 233, 152, 3)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sports()));
                        },
                        child: Icon(Icons.sports),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 19, 233, 90)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Songs()));
                        },
                        child: Icon(Icons.music_note),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
