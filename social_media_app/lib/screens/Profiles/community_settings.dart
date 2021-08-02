import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class CommunitySettings extends StatelessWidget {
  // const ({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Text(
              'Manage your community',
              style: kTitleTextStyle,
            ),
          ),

          ListTile(
            leading: Icon(Icons.group),
            title: Text('Managers'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add event'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          // ListTile(
          //   leading: Icon(Icons.block),
          //   title: Text('Blocked'),
          //   trailing: Icon(Icons.arrow_forward_ios_rounded),
          // ),
          // ListTile(
          //   leading: Icon(Icons.logout),
          //   title: Text('Delete Community'),
          //   trailing: Icon(Icons.close),
          //   onTap: () {},
          // ),
          // Container(
          //   margin: EdgeInsets.only(
          //     left: 15,
          //     right: 15,
          //   ),
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         primary: Color.fromRGBO(69, 83, 243, 1)),
          //     onPressed: () {},
          //     child: Text('Logout'),
          //   ),
          // ),
        ],
      ),
    );
  }
}
