import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/community.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/secureStorage.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:social_media_app/widgets/profile_events.dart';
import 'package:social_media_app/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  User user;
  Community community;

  bool isUserProfile;

  ProfileScreen.user() {
    Api.getUser().then((value) => user = value);
    isUserProfile = true;
  }

  ProfileScreen.community(Community community) {
    this.community = community;
    isUserProfile = false;
  }
  // const ProfileScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user.bio);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileHeader(
              coverImg:
                  isUserProfile ? user?.coverImage : community?.coverImage,
              profileImg: isUserProfile ? user?.image : community?.image,
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${isUserProfile ? user?.name : community?.name}',
                  style: kProfileName,
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 200,
                  child: Text(
                    '${isUserProfile ? user?.bio : ''}',
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
                      '${isUserProfile ? user?.followers : community?.followers} Followers' ??
                          0,
                      style: kProfileLabel,
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (!isUserProfile)
                      Icon(
                        Icons.wallet_membership_outlined,
                        color: Colors.red,
                      ),
                    if (isUserProfile)
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    if (!isUserProfile)
                      Text(
                        '${community?.members} Members' ?? 0,
                        style: kProfileLabel,
                      ),
                    if (isUserProfile)
                      Text(
                        '${user?.likes} Likes' ?? 0,
                        style: kProfileLabel,
                      ),
                  ],
                ),
                Row(
                  children: [
                    if (!isUserProfile)
                      Icon(
                        MdiIcons.medal,
                        color: Colors.purpleAccent,
                      ),
                    if (isUserProfile)
                      Icon(
                        MdiIcons.medal,
                        color: Colors.purpleAccent,
                      ),
                    if (!isUserProfile)
                      Text(
                        '${community?.events} Events' ?? 0,
                        style: kProfileLabel,
                      ),
                    if (isUserProfile)
                      Text(
                        '${user?.achievements} Achievements' ?? 0,
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
                Expanded(
                  child: Ink(
                    height: 38,
                    decoration: BoxDecoration(
                      gradient: kButtonLinearGradient,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        SecureStorage.readApiToken()
                            .then((value) => print(value));
                      },
                      child: Text(
                        !isUserProfile ? '+Join' : 'Follow',
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
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      SecureStorage.readUid().then((value) => print(value));
                    },
                    child: Text(
                      !isUserProfile ? 'Contact Head' : 'Send a message',
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
                SizedBox(width: 5),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.logout();
                    },
                    child: Text(
                      !isUserProfile ? 'Edit Community' : 'Edit Profile',
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
                SizedBox(width: 15),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Events',
                  style: kProfileTitle,
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            ProfileEvents(),
          ],
        ),
      ),
    ));
  }
}
