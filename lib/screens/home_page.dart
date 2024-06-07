import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:yolo/widgets/custom_elevated_button.dart';
import 'package:yolo/widgets/drawer.dart';

import '../commons/utils/firebase_methods.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        drawer: const SideDrawer(),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: const Text(
                        'Welcome back',
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 45.0,
                      backgroundImage: AssetImage('assets/images/p.jpeg'),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 20.0,),

              const SizedBox(
                height: 90.0,
              ),
              const Text(
                'Select an activity',
                style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 140,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade400,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 140,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade400,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Text(
                      "Capture Plate Number",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0),
                    child: Text(
                      "Upload ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Container(
                  height: 140,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade400,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_alt_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Input",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),

              // Center(
              //     child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     const Padding(
              //       padding: EdgeInsets.only(left: 20),
              //       child: Text(
              //         'Welcome back',
              //         style: TextStyle(
              //             fontSize: 25,
              //             color: Colors.black,
              //             fontWeight: FontWeight.w700),
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 50,
              //     ),
              //     const Center(
              //         child: Text(
              //       "Please Select An Activity To Continue",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //     )),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     Column(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Row(
              //           children: [
              //           Container(
              //               height: 110,
              //               width: 260,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: Colors.grey.shade400,
              //               ),
              //               child: const Column(
              //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                 children: [
              //                   Icon(
              //                     Icons.photo_camera,
              //                     color: Colors.white,
              //                     size: 30,
              //                   ),
              //                   Text(
              //                     "Capture Car Number And Validate",
              //                     textAlign: TextAlign.center,
              //                     style: TextStyle(
              //                         color: Colors.black54,
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                 ],
              //               )),
              //         ]),
              //       ],
              //     ),

              //     // Padding(
              //     //   padding: const EdgeInsets.symmetric(horizontal: 80),
              //     //   child: CustomElevatedButton(
              //     //       onPressed: () {},
              //     //       label: "Start",
              //     //       backgroundColor: Colors.blue),
              //     // ),
              //     const SizedBox(
              //       height: 70,
              //     ),
              //     Container(
              //       height: 140,
              //       width: 260,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.grey.shade400,
              //       ),
              //       child: const Column(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Icon(
              //             Icons.type_specimen,
              //             color: Colors.white,
              //             size: 30,
              //           ),
              //           Text(
              //             "Enter Car Number  And Validate",
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 color: Colors.black54,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.bold),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 20,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 80),
              //       child: CustomElevatedButton(
              //           onPressed: () {}, label: "Start", backgroundColor: Colors.blue),
              //     )
            ],
          ),
        ));
  }
}
