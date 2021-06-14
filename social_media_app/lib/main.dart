import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/screens/feed_screen.dart';
import 'package:social_media_app/widgets/app_bar.dart';
import 'package:social_media_app/widgets/post_item.dart';

import 'dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: TextTheme(
        //   title: TitleTextStyle,
        //   subtitle: SubtitleTextStyle,
        //   body1: BodyprimaryTextStyle,
        //   body2: BodySecondaryTextStyle,
        // )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _childern = [Container(), FeedScreen(), Container()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Container(
          child: Icon(Icons.add,size:30,),
          width:60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(98, 65, 234, 1),
                Color.fromRGBO(219, 0, 255, 1),
              ],
            ),
          ),
        ),
        elevation: 2.0,
      ),
      body: _childern.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            selectedItemColor: kPrimaryColor,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: 'Account'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Feed'),
            ],
          ),
        ),
      ),
    );
  }
}
