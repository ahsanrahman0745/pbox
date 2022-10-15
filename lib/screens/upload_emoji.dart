import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pbox/widgets/responsive.dart';

class UploadEmoji extends StatelessWidget {
  final String artistemail;
  UploadEmoji({super.key, required this.artistemail});
  final List celebdata = [];
  late File? _pickedImage;
  late String ImgURL;
  final _formKey = GlobalKey<FormState>();
  final PriceEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PriceField = TextFormField(
      autofocus: false,
      controller: PriceEditingController,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        PriceEditingController.text = value!;
      },
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'Enter Price First';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: 'Enter Price',
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(top: 10.0, left: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.grey),
          )),
    );

    final uploadbutton = Material(
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            upload_image();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Uploading Image')),
            );
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UploadEmoji(artistemail: artistemail)));
          }
        },
        child: Text(
          'Upload Emoji & Price',
        ),
        style: TextButton.styleFrom(
            minimumSize: Size(300, 40),
            primary: Colors.white,
            backgroundColor: Colors.indigo),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_double_arrow_left,
              size: 10.0,
            ),
            label: const Text(
              'BACK',
              style: TextStyle(fontSize: 10),
            ),
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                side: BorderSide(width: 1, color: Colors.white),
                minimumSize: Size(20, 20),
                primary: Colors.white,
                backgroundColor: Colors.transparent),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Text(
              'UPLOAD EMOJI',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'SEE ALL',
              style: TextStyle(fontSize: 10),
            ),
            style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                side: BorderSide(width: 1, color: Colors.white),
                minimumSize: Size(20, 20),
                primary: Colors.white,
                backgroundColor: Colors.transparent),
          ),
        ]),
        //centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.blue, Colors.lightBlueAccent]),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            height: 700,
            width: MediaQuery.of(context).size.width - 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 150,
                        height: 70,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: PriceField,
                          ),
                        )),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 150,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: uploadbutton,
                      ),
                    ),
                  ]),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('ArtistBids')
                        .where("email", isEqualTo: artistemail)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width *
                                    0.7 /
                                    (MediaQuery.of(context).size.height *
                                        0.4 /
                                        1)
                        ),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return Row(
                            children: [
                              if (ResponsiveWidget.isSmallScreen(context))
                                GestureDetector(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: doc['ImageURL'],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                  // colorFilter:
                                                  // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.013,top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.53),
                                                child: Text(
                                                  "Price",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.013,top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.53),
                                                child: Text(
                                                  "\$"+doc['Price'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.044),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    //artistemail = doc['Email'];
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                  },
                                ),
                              if (ResponsiveWidget.isMediumScreen(context))
                                GestureDetector(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: doc['ImageURL'],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                  // colorFilter:
                                                  // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    //artistemail = doc['Email'];
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                  },
                                ),
                              if (ResponsiveWidget.isLargeScreen(context))
                                GestureDetector(
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: doc['ImageURL'],
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                  // colorFilter:
                                                  // ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ],
                                      )),
                                  onTap: () {
                                    //artistemail = doc['Email'];
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(builder: (context) => ArtistProfile(email: email , artistemail: artistemail)));
                                  },
                                ),
                            ],
                          );
                        },
                      );
                    }),
              )
            ]),
          ),
        ],
      ),
    );
  }

  Future upload_image() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);

    final ref = FirebaseStorage.instance
        .ref()
        .child("UserImages")
        .child(artistemail + ".jpg");
    await ref.putFile(pickedImageFile as File);
    ImgURL = await ref.getDownloadURL();

    Map<String, dynamic> ArtistBids = {
      "ImageURL": ImgURL,
      "Price": PriceEditingController.text,
      "email": artistemail,
    };

    await FirebaseFirestore.instance
        .collection("ArtistBids")
        .doc(artistemail)
        .set(ArtistBids)
        .whenComplete(() {
      print("$PriceEditingController.text uploaded");
    });
  }
}
