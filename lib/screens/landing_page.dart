import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:yolo/screens/sign_up.dart';
import 'package:yolo/widgets/box_image.dart';
import 'package:yolo/widgets/carousel_slider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BoxImageDecoration(
          imageUrl: "assets/images/1.jpg",
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const CarouselImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: double.infinity,
                    height: 50,
                    child: const Center(
                      child: Text(
                        "GET STARTED",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ).asGlass(
                    enabled: true,
                    tintColor: Colors.transparent,
                    clipBorderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
