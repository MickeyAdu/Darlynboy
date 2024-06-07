import "package:smooth_page_indicator/smooth_page_indicator.dart";

import "package:flutter/material.dart";
import 'package:carousel_slider/carousel_slider.dart';
import "package:yolo/commons/utils/global_variables.dart";

class CarouselImage extends StatefulWidget {
  const CarouselImage({super.key});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
            items: GlobalVariables.texts.map((text) {
              return Builder(
                  builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                letterSpacing: 1.5),
                          ),
                        ),
                      ));
            }).toList(),
            options: CarouselOptions(
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
                height: 200,
                autoPlay: true,
                reverse: true,
                viewportFraction: 1,
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayInterval: const Duration(seconds: 20),
                enableInfiniteScroll: true)),
        const SizedBox(
          height: 20,
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        effect: const WormEffect(
          dotHeight: 10,
          dotWidth: 10,
        ),
        count: GlobalVariables.images.length,
      );
}
