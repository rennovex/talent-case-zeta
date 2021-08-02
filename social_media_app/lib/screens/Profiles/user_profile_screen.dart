import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/profile_header.dart';

import 'user_settings.dart';

import '../../constants.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/userProfileScreen';
  final userId;

  UserProfileScreen({this.userId});

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<UserProfileScreen>
    with AutomaticKeepAliveClientMixin {
  Future<User> future;
  User user;
  bool isMe;

  @override
  void initState() {
    super.initState();
    widget.userId == null
        ? future = Api.getUser()
        : future = Api.getUserWithId(widget.userId);
    // Api.getsnapshot().then((value) => snapshot = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            user = snapshot.data;
            isMe = user.uid == Global.uid ? true : false;
            return SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileHeader(
                    coverImg: user?.coverImage,
                    profileImg: user?.image,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${user?.name}',
                        style: kProfileName,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          '${user.bio ?? ''}',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          Text(
                            '${user.followers?.length ?? 0} Followers',
                            style: kProfileLabel,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          Text(
                            '${user?.likes ?? 0} Likes',
                            style: kProfileLabel,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            MdiIcons.medal,
                            color: Colors.purpleAccent,
                          ),
                          Text(
                            '${user.following?.length ?? 0} Following',
                            style: kProfileLabel,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      if (isMe)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              print(user.likes);
                            },
                            child: Text(
                              'Edit Profile',
                              textAlign: TextAlign.center,
                              style: kProfileButtonText,
                            ),
                            style: OutlinedButton.styleFrom(
                              primary: Color.fromRGBO(40, 102, 253, 1),
                              backgroundColor: Colors.transparent,
                              side: BorderSide(
                                width: 1.3,
                                color: Color.fromRGBO(40, 102, 253, 1),
                              ),
                            ),

                            // color: Colors.purpleAccent,
                          ),
                        ),
                      if (!isMe)
                        Expanded(
                          child: Ink(
                            height: 38,
                            decoration: BoxDecoration(
                              gradient: kButtonLinearGradient,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Follow',
                                textAlign: TextAlign.center,
                                style: kProfileButtonText,
                              ),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: 5),
                      if (isMe)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => showModalBottomSheet<dynamic>(
                              context: context,
                              builder: (context) => UserSettings(),
                            ),
                            child: Text(
                              'Settings',
                              textAlign: TextAlign.center,
                              style: kProfileButtonText,
                            ),
                            // color: Colors.purpleAccent,
                            style: OutlinedButton.styleFrom(
                              primary: Color.fromRGBO(225, 37, 255, 1),
                              backgroundColor: Colors.transparent,
                              side: BorderSide(
                                width: 1.3,
                                color: Color.fromRGBO(225, 37, 255, 1),
                              ),
                            ),
                          ),
                        ),
                      if (!isMe)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Send a message',
                              textAlign: TextAlign.center,
                              style: kProfileButtonText,
                            ),
                            // color: Colors.purpleAccent,
                            style: OutlinedButton.styleFrom(
                              primary: Color.fromRGBO(225, 37, 255, 1),
                              backgroundColor: Colors.transparent,
                              side: BorderSide(
                                width: 1.3,
                                color: Color.fromRGBO(225, 37, 255, 1),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          }
        },
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
