import 'package:camp_booking/constant.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8 / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}

class HalfRounded extends StatelessWidget {
  const HalfRounded({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8 / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ListSkeleton(size) => SizedBox(
      width: size.width > 600 ? 400 : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Skeleton(
                height: 100,
                width: 100,
              ),
              width(10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(width: 100, height: 20),
                  height(5),
                  const Skeleton(
                    width: 200,
                    height: 30,
                  ),
                  height(5),
                  const Skeleton(
                    width: 80,
                    height: 20,
                  )
                ],
              ))
            ],
          ),
          height(10),
          Row(
            children: [
              const Expanded(child: Skeleton(height: 35)),
              width(5),
              const Expanded(child: Skeleton(height: 35)),
            ],
          ),
          height(5),
          const Divider(),
          height(5)
        ],
      ),
    );

Widget campSkelton(size) => Wrap(
    children: List.generate(
        5,
        (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HalfRounded(
                    width: size < 600 ? size * 0.8 : 270,
                    height: 150,
                  ),
                  height(5),
                  Row(
                    children: [
                      const Skeleton(width: 150, height: 30),
                      width(15),
                      const Skeleton(width: 60, height: 30),
                    ],
                  ),
                  height(5),
                  const Skeleton(width: 170, height: 30),
                  height(5),
                  Row(
                    children: [
                      const Skeleton(width: 120, height: 30),
                      width(55),
                      const Skeleton(width: 90, height: 30),
                    ],
                  ),
                ],
              ),
            )));
