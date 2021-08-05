import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tweety/configurations/app_shared_data.dart';
import 'package:tweety/screens/common_components/background/common_background_component.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_constants.dart';
import 'package:tweety/utils/app_images.dart';
import 'package:tweety/utils/injection_container.dart';

import '../../base_view.dart';

class HomeView extends BaseView {
  @override
  _HomeViewState createState() => _HomeViewState();
}

int id = 0;

class _HomeViewState extends BaseViewState {

  ///Firebase current user object
  final user = FirebaseAuth.instance.currentUser!;

  ///Text editors
  TextEditingController addTweetController = TextEditingController();
  TextEditingController editTweetController = TextEditingController();

  ///Shared preference
  final sharedData = sl<AppSharedData>();

  /// Global Keys
  GlobalKey<FormState> addTweetKey = GlobalKey();
  GlobalKey<FormState> editTweetKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    /// Get the existing ID of the collection
    getIdFromShared();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(

          ///Listening the collection
            stream: FirebaseFirestore.instance.collection('tweets').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Something is Wrong!!'),
                );
              } else if (snapshot.hasData) {
                return CommonBackgroundComponent(
                  bottomSheetHeight: 780,
                  profile: true,
                  profileImage: user.photoURL!,
                  name: user.displayName!,
                  email: user.email!,
                  children: [
                    snapshot.data!.docs.length == 0

                    ///No data in the collection
                        ? Positioned(
                      top: adaptiveScreen.setHeight(300),
                      child: Container(
                        width: adaptiveScreen.setWidth(428),
                        child: Column(
                          children: [
                            Container(
                                height: adaptiveScreen.setHeight(300),
                                width: adaptiveScreen.setWidth(400),
                                child: Image.asset(AppImages.noTweets)),
                            Text(
                              "Uh oh, Seems like there is no any message for you",
                              style: TextStyle(
                                fontSize: adaptiveScreen.setSp(16),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                        :

                    ///Has data in the collection
                    Positioned(
                      top: adaptiveScreen.setHeight(170),
                      left: adaptiveScreen.setWidth(20),
                      right: adaptiveScreen.setWidth(20),
                      child: Container(
                        height: 600,
                        width: 500,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            return Card(
                              elevation: 4,
                              child: ListTile(
                                title: Text(snapshot
                                    .data!.docs[i]['message']
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data!.docs[i]['timeStamp']
                                    .toString()),
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:AppColors.white,
                                  backgroundImage:
                                  NetworkImage(user.photoURL!),
                                ),
                                onLongPress: () {
                                  deleteTweet(i);
                                },
                                trailing: IconButton(
                                  onPressed: () {
                                    editTweetController.value =
                                        new TextEditingController
                                            .fromValue(
                                            new TextEditingValue(
                                                text: snapshot
                                                    .data!.docs[i]
                                                ['message']))
                                            .value;
                                    editTweet(snapshot.data!.docs[i], i);
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.edit,
                                    size: 20,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: adaptiveScreen.setHeight(10),
                      right: adaptiveScreen.setWidth(20),
                      child: FloatingActionButton(
                        onPressed: () {
                          ///Viewing add tweet pop up
                          viewAddTweet();
                        },
                        backgroundColor: AppColors.primaryButtonBackgroundColor,
                        child: FaIcon(FontAwesomeIcons.twitter),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  /// Add tweet pop up
  viewAddTweet() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(adaptiveScreen.setHeight(30)))),
            contentPadding: EdgeInsets.only(top: adaptiveScreen.setHeight(10)),
            content: Container(
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Add Tweet', style: textStyles.commonTextStyle(),),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: adaptiveScreen.setHeight(20),
                        right: adaptiveScreen.setHeight(10)),
                    child: Form(
                      key: addTweetKey,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: addTweetController,
                        decoration: InputDecoration(
                          hintText: "Please enter your tweet",
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Empty value can not be accepted';
                          }
                          if (value.length > 280) {
                            return ' Max length is 280 characters';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 10,
                        maxLength: 280,
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: adaptiveScreen.setHeight(10),
                      ),
                      padding: EdgeInsets.all(
                          adaptiveScreen.setHeight(20)),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackgroundColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(adaptiveScreen.setHeight(30)),),
                      ),
                      child: Text(
                        "Add Tweet",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      /// Adding tweet to the collection
                      if (addTweetKey.currentState!.validate()) {
                        addTweetToFirestore(
                            addTweetController.text.toString().trim());
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger(
                          child: SnackBar(
                            content: Text('Something is wrong'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Editing tweets
  editTweet(QueryDocumentSnapshot<Object?> doc, int i) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(adaptiveScreen.setHeight(30)))),
            contentPadding: EdgeInsets.only(top: adaptiveScreen.setHeight(10)),
            content: Container(
              width: 400.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Edit Tweet', style: textStyles.commonTextStyle(),),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: adaptiveScreen.setHeight(20),
                        right: adaptiveScreen.setHeight(10)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      controller: editTweetController,
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Empty value can not be accepted';
                        }
                        if (value.length > 280) {
                          return ' Max length is 280 characters';
                        } else {
                          return null;
                        }
                      },
                      maxLines: 10,
                      maxLength: 280,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: adaptiveScreen.setHeight(10),
                      ),
                      padding: EdgeInsets.all(
                          adaptiveScreen.setHeight(20)),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBackgroundColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(adaptiveScreen.setHeight(30)),),
                      ),
                      child: Text(
                        "Edit Tweet",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      /// Editing tweet inside the collection
                      if (editTweetKey.currentState!.validate()) {
                        editTweetToFirestore(
                            editTweetController.text.toString().trim(), i);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger(
                          child: SnackBar(
                            content: Text('Something is wrong'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Adding to the collection method
  /// params String [tweet]
  void addTweetToFirestore(String tweet) async {
    try {
      String timeStamp = getTime();
      Map<String, dynamic> data = {
        'message': tweet,
        'timeStamp': timeStamp
      };
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('tweets');
      await collectionReference.doc(id.toString()).set(data);
      ++id;
      await sharedData.setData("ID", id.toString());
    } catch (e) {
      print("ADD_COLLECTION_TAG" + e.toString());
    }
  }

  /// Edit tweet in the collection
  /// params String [tweet] and  int [collection_id]
  void editTweetToFirestore(String tweet, int i) async {
    try {
      String timeStamp = getTime();
      Map<String, dynamic> data = {
        'message': tweet,
        'timeStamp': timeStamp
      };
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('tweets');
      QuerySnapshot querySnapshot = await collectionReference.get();
      querySnapshot.docs[i].reference.update(data);
    } catch (e) {
      print("EDIT_COLLECTION_TAG" + e.toString());
    }
  }

  /// Delete tweet from the collection
  /// params int [collection_id]
  void deleteTweet(int i) async {
    try {
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('tweets');
      QuerySnapshot querySnapshot = await collectionReference.get();
      querySnapshot.docs[i].reference.delete();
    } catch (e) {
      print("DELETE_COLLECTION_TAG" + e.toString());
    }
  }

  /// Fetching all the data from the collection
  fetchTweets() {
    try {
      CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('tweets');
      collectionReference.snapshots().listen((snapshot) {
        List tweets;
        setState(() {
          tweets = snapshot.docs;
          print(tweets);
        });
      });
    } catch (e) {
      print("FETCH_COLLECTION_TAG" + e.toString());
    }
  }

  /// Getting the existing id of the current object
  void getIdFromShared() async {
    id = int.parse(sharedData.getData("ID") ?? "0");
  }

  /// Formatting the date to [22-07-2021 12:12 a.m] format
  String getTime() {
    final timeStampFormatter = new DateFormat('dd-MM-yyyy hh:mm a');
    return timeStampFormatter.format(DateTime.now());
  }

}
