import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../themes/theme_notifier.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  String _username = "User"; // Default name

  String _fullusername = "User"; // Default name
  String _email = "email@gmail.com"; //default
  String _phone = "(233 xxx xxxx)";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userData.exists) {
          setState(() {
            _username = userData["first_name"] ?? 'user';
          });
        } else {
          setState(() {
            _username = 'user';
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          _username = 'user';
        });
      }
    } else {
      setState(() {
        _username = 'user';
      });
    }
  }
  // void _fetchUserName() async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     DocumentSnapshot userData = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user.uid)
  //         .get();
  //     if (userData.exists) {
  //       String firstName = userData["first_name"];
  //       String lastName = userData["last_name"];
  //       String email = userData["email"];
  //       String phone = userData["phone"];

  //       if (firstName != null &&
  //           lastName != null &&
  //           email != null &&
  //           phone != null) {
  //         setState(() {
  //           _fullusername = "$firstName $lastName";
  //           _email = "$email";
  //           _phone = "$phone";
  //         });
  //       } else {
  //         setState(() {
  //           _fullusername = "User"; // Default username if names are missing
  //           _email = "email@gmail.com";
  //           _phone = "(233 xxx xxxx)";
  //         });
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final phoneHeight = MediaQuery.of(context).size.height;
    // final phoneWidth = MediaQuery.of(context).size.width;
    return Container(
      color: const Color.fromRGBO(245, 124, 0, 1),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            height: 60,
            child: const CircleAvatar(
              radius: 32.0,
              backgroundImage: AssetImage('assets/woman.png'),
            ),
          ),
          Text(
            '$_username',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.normal,
            ),
          ),
          // Text(
          //   '$_email',
          //   style: TextStyle(
          //     fontFamily: 'Poppins',
          //     fontSize: 22,
          //     color: Colors.white,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
          // Text(
          //   '$_phone',
          //   style: TextStyle(
          //     fontFamily: 'Poppins',
          //     fontSize: 22,
          //     color: Colors.white,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
          // SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
