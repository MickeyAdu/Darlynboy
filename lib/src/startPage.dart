import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mic_fuel/screens/sign_in_screen.dart';
import 'package:mic_fuel/screens/sign_up_screen.dart';
import 'package:mic_fuel/src/home.dart';
import 'package:mic_fuel/src/login.dart';
import 'package:mic_fuel/src/quick.dart';
import 'package:mic_fuel/src/signup.dart';

import '../themes/colors.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPage();
}

Widget button(height, width, Color color, String label, Color textcolor,
    Widget page, BuildContext context) {
  return InkWell(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    )),
    child: Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: height * 0.015),
      margin: EdgeInsets.symmetric(horizontal: width * 0.03)
          .copyWith(bottom: height * 0.02),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 41, 41, 41),
                offset: Offset(0.0, 0.0),
                spreadRadius: 1.0,
                blurRadius: 6.0)
          ]),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
                fontSize: 21, fontFamily: "Poppins", color: textcolor),
          )),
    ),
  );
}

class _StartPage extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final phoneHeight = MediaQuery.of(context).size.height;
    final phoneWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [KColors.primaryOrange, KColors.primaryYellow])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: phoneHeight,
              width: phoneWidth,
              color: Colors.black54,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: phoneWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Say goodbye to a fuel station!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: phoneHeight * 0.02),
                  const Text(
                    "we're on-demand fuel delivery application that allows its users to order fuel for their vehicle anytime, anywhere",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: phoneHeight * 0.25),
                  // Container(
                  //   height: phoneHeight * 0.2,
                  //   width: phoneWidth * 0.2,
                  //   child: Lottie.network(
                  //       'https://lottie.host/embed/e9eafea5-784e-4b40-82df-a677f709cf42/yJbkYQxb49.json'),
                  // ),
                  // SizedBox(height: phoneHeight * 0.25),
                  button(phoneHeight, phoneWidth, KColors.primaryOrange,
                      "Sign in", Colors.white, const LogIn(), context),
                  button(phoneHeight, phoneWidth, KColors.primaryOrange,
                      "Create Account", Colors.white, Signup(), context),
                  button(
                      phoneHeight,
                      phoneWidth,
                      const Color(0xFF3E3939),
                      "Continue as Guest",
                      KColors.primaryOrange,
                      const Home(),
                      context),
                ],
              ),
            ),
            // Ink.image(
            //   image: const AssetImage('assets/alterSize.png'),
            //   height: double.infinity,
            //   fit: BoxFit.cover,
            // ),
            // Container(
            //   height: phoneHeight,
            //   width: phoneWidth,
            //   color: Colors.black38,
            // ),
            // Container(),
            // const Positioned(
            //   top: 200,
            //   left: 30,
            //   right: 30,
            //   child: Center(
            //     child: Text(
            //       'Say goodbye to a fuel station!',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 40.0,
            //         fontFamily: 'Poppins',
            //         color: Colors.black,
            //         fontWeight: FontWeight.w900,
            //       ),
            //     ),
            //   ),
            // ),
            // const Positioned(
            //   top: 340,
            //   left: 60,
            //   right: 60,
            //   child: Center(
            //     child: Text(
            //       "we're on-demand fuel delivery application that allows its users to order fuel for their vehicle anytime, anywhere",
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 19.0,
            //         fontFamily: 'Poppins',
            //         color: Colors.black,
            //         fontWeight: FontWeight.normal,
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   bottom: 5.0,
            //   left: 0,
            //   right: 0,
            //   child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20.0, 1.5, 20.0, 1.5),
            //         child: SizedBox(
            //           width: double.infinity,
            //           height: 52,
            //           child: ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10.0))),
            //             onPressed: () async {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => const LogIn(
            //                           label: 'Password',
            //                         )),
            //               );
            //             },
            //             child: const Text(
            //               "Sign In",
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 21,
            //                   fontFamily: 'Poppins',
            //                   color: Colors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 5.0,
            //         width: double.infinity,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20.0, 1.5, 20.0, 1.5),
            //         child: SizedBox(
            //           width: double.infinity,
            //           height: 52,
            //           child: ElevatedButton(
            //             style: ElevatedButton.styleFrom(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(10.0))),
            //             onPressed: () async {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => const SignUp(
            //                           label: 'Password',
            //                         )),
            //               );
            //             },
            //             child: const Text(
            //               "Create Account",
            //               style: TextStyle(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 21,
            //                   fontFamily: 'Poppins',
            //                   color: Colors.black),
            //             ),
            //           ),
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 5.0,
            //         width: double.infinity,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.fromLTRB(20.0, 1.5, 20.0, 1.5),
            //         child: Container(
            //           decoration: const BoxDecoration(),
            //           child: SizedBox(
            //             width: double.infinity,
            //             height: 52,
            //             child: ElevatedButton(
            //               style: ElevatedButton.styleFrom(
            //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //                   backgroundColor: const Color(0xFF3E3939),
            //                   foregroundColor: const Color(0xFFBEB573),
            //                   shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(10.0)),
            //                   textStyle: const TextStyle(
            //                       fontSize: 21,
            //                       fontFamily: 'Poppins',
            //                       fontWeight: FontWeight.bold)),
            //               onPressed: () async {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => const Home()),
            //                 );
            //               },
            //               child: const Text("Continue As Guest"),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  //  @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.asset('assets/background_video.mp4')
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized
  //       setState(() {});
  //     })
  //     ..play()
  //     ..setLooping(true);
  // }
  Future<Widget> _loadLottieAnimation() async {
    try {
      return Lottie.network(
        'https://lottie.host/embed/e9eafea5-784e-4b40-82df-a677f709cf42/yJbkYQxb49.json',
        width: 300, // adjust width and height as per your requirements
        height: 300,
        fit: BoxFit.cover, // adjust the fit as per your requirements
      );
    } catch (e) {
      throw Exception('Failed to load animation: $e');
    }
  }
}
