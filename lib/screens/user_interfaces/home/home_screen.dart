import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tweety/configurations/app_shared_data.dart';
import 'package:tweety/screens/common_components/background/common_background_component.dart';
import 'package:tweety/utils/app_colors.dart';
import 'package:tweety/utils/app_images.dart';
import 'package:tweety/utils/injection_container.dart';

import '../../base_view.dart';

class HomeView extends BaseView {
  @override
  _HomeViewState createState() => _HomeViewState();
}

int id = 0;

class _HomeViewState extends BaseViewState {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController addTweetController = TextEditingController();
  TextEditingController editTweetController = TextEditingController();
  final sharedData = sl<AppSharedData>();

  @override
  void initState() {
    super.initState();
    getIdFromShared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
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
                        ? Positioned(
                            top: adaptiveScreen.setHeight(300),
                            child: Container(
                              width: adaptiveScreen.setWidth(428),
                              child: Column(
                                children: [
                                  Container(
                                    height:adaptiveScreen.setHeight(300) ,
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
                        : Positioned(
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
                      child: Text('Add Tweet',style: textStyles.commonTextStyle(),),
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
                      controller: addTweetController,
                      decoration: InputDecoration(
                        hintText: "Please enter your tweet",
                        border: InputBorder.none,
                      ),
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
                        "Add Tweet",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      addTweetToFirestore(
                          addTweetController.text.toString().trim());
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

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
                      child: Text('Edit Tweet',style: textStyles.commonTextStyle(),),
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
                      controller: editTweetController,
                      decoration: InputDecoration(
                        hintText: "",
                        border: InputBorder.none,
                      ),
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
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      editTweetToFirestore(
                          editTweetController.text.toString().trim(), i);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void addTweetToFirestore(String tweet) async {
    String timeStamp = getTime();
    Map<String, dynamic> data = {
      'message': tweet,
      'timeStamp': timeStamp
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('tweets');
    await collectionReference.doc(id.toString()).set(data);
    ++id;
    await sharedData.setData(ID, id.toString());
  }

  void editTweetToFirestore(String tweet, int i) async {
    String timeStamp = getTime();
    Map<String, dynamic> data = {
      'message': tweet,
      'timeStamp': timeStamp
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('tweets');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[i].reference.update(data);
  }

  void deleteTweet(int i) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('tweets');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[i].reference.delete();
  }

  fetchTweets() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('tweets');
    collectionReference.snapshots().listen((snapshot) {
      List tweets;
      setState(() {
        tweets = snapshot.docs;
        print(tweets);
      });
    });
  }

  void getIdFromShared() async {
    id = int.parse(sharedData.getData(ID)??"0");
  }

  String getTime() {
    final timeStampFormatter = new DateFormat('dd-MM-yyyy hh:mm a');
    return timeStampFormatter.format(DateTime.now());
  }
}
