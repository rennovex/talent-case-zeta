import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: kAppBarBoxDecoration,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1868&q=80',
                    ),
                    radius: 20,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none, //removes borderline
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(82, 82, 82, 1),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          hintText: 'Search',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              backgroundColor: Color.fromRGBO(82, 82, 82, 1))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.near_me,
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
