// ignore_for_file: sort_child_properties_last, prefer_const_constructors, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterGalleryBid extends StatelessWidget {
  final String email;
  final String artistemail;
  final String imageurl;
  final List imgdata = [];

  EnterGalleryBid({super.key, required this.email, required this.artistemail, required this.imageurl});

  final _formKey = GlobalKey<FormState>();
  final TimeEditingController = new TextEditingController();
  final DateEditingController = new TextEditingController();
  final EmailEditingController = new TextEditingController();
  final BidAmountEditingController = new TextEditingController();

  Future _BidEnter(artistname) async {
    Map<String, dynamic> EnterGalleryBid = {
      "Time": TimeEditingController.text,
      "Date": DateEditingController.text,
      "Email": email,
      "ArtistEmail": artistemail,
      "Amount": BidAmountEditingController.text,
      "ImageURL": imageurl,
    };
    print(TimeEditingController.text);
    print(DateEditingController.text);
    print(BidAmountEditingController.text);
    print(imageurl);

    await FirebaseFirestore.instance
        .collection("EnterGalleryBid")
        .doc(email)
        .set(EnterGalleryBid)
        .whenComplete(() {
      print("$email.text created");
    });

    Map<String, dynamic> History = {
      "email": email,
      "activity": "You Bid on $artistname Image",
    };

    await FirebaseFirestore.instance
        .collection("History")
        .doc()
        .set(History)
        .whenComplete(() {
      print("$email.History created");
    });
  }

  @override
  Widget build(BuildContext context) {
    final EventField = CachedNetworkImage(
      imageUrl: imageurl,
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.25,
      imageBuilder: (context, imageProvider) =>
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
          Center(
            child: CircularProgressIndicator(),
          ),
      errorWidget: (context, url, error) =>
          Icon(Icons.error),
    );
    final TimeField = TextFormField(
        autofocus: false,
        controller: TimeEditingController,
        //keyboardType: TextInputType.text,
        onSaved: (value) {
          TimeEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintText: 'Select Time',
            labelText: 'Time',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );

          if (pickedTime != null) {
            print(pickedTime.format(context)); //output 10:51 PM
            DateTime parsedTime =
            DateFormat.jm().parse(pickedTime.format(context).toString());
            //converting to DateTime so that we can further format on different pattern.
            print(parsedTime); //output 1970-01-01 22:53:00.000
            String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
            print(formattedTime); //output 14:59:00
            //DateFormat() is from intl package, you can format the time on any pattern you need.

            TimeEditingController.text = formattedTime;
          }
        });
    final DateField = TextFormField(
        autofocus: false,
        controller: DateEditingController,
        //keyboardType: TextInputType.text,
        onSaved: (value) {
          DateEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintText: 'Enter Date',
            labelText: 'Date',
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100));

          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            DateEditingController.text = formattedDate;
          }
        });
    final BidAmountField = TextFormField(
      autofocus: false,
      controller: BidAmountEditingController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        BidAmountEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: 'Enter Bid Amount',
          labelText: 'Bid Amount',
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      validator: (String? text) {
        if (text == null || text.isEmpty) {
          return 'Please provide Bid Amount';
        }
      },
    );
    //final Email = Text(email);
    final EnterBidButton = Material(
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String artistname = imgdata[0]['Name'];
            _BidEnter(artistname);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Your Bid has been successfully entered.')),
            );
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (context) => MyBidPage(email: email)));
          }
        },
        child: Text(
          '49:05:10                                SUBMIT',
        ),
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            minimumSize: Size(300, 40),
            primary: Colors.white,
            backgroundColor: Colors.indigo),
      ),
    );

    final Stream<QuerySnapshot> imgstream = FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: artistemail)
        .snapshots();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.keyboard_double_arrow_left,
                    size: 10.0,
                  ),
                  label: const Text(
                    'Back',
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
                  padding: EdgeInsets.only(
                    left: 50,
                  ),
                  child: Text(
                    'ENTER GALLERY BID',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.transparent, Colors.lightBlueAccent]),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.blue,
        body: Stack(children: <Widget>[
          StreamBuilder<QuerySnapshot>(
          stream: imgstream,
          builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            snapshot.data!.docs.map((DocumentSnapshot e) {
              Map dis = e.data() as Map<String, dynamic>;
              imgdata.add(dis);
            }).toList();
            return Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: MediaQuery.of(context).size.height*0.34,
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: imgdata[0]['ImageURL'],
                      height: MediaQuery.of(context).size.height*0.34,
                      imageBuilder: (context, imageProvider) =>
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
                    ),
                  ],
                ),


              ),
            );
          }),
          Positioned(
            top: 150,
            // child: Expanded(
            // child: SingleChildScrollView(
            child: Container(
                height: 450,
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
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              EventField,
                              const SizedBox(
                                height: 10,
                              ),
                              TimeField,
                              const SizedBox(
                                height: 10,
                              ),
                              DateField,
                              const SizedBox(
                                height: 10,
                              ),
                              BidAmountField,
                              const SizedBox(
                                height: 10,
                              ),
                              EnterBidButton,
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ])),
            // )
            // )
          )
        ]));
  }
}
