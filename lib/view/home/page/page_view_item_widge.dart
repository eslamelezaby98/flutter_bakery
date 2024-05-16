import 'package:flutter/material.dart';
import 'package:flutter_bakery/config/data/dummy_data.dart';
import 'package:flutter_bakery/view/home/model/cupcake_model.dart';

class PageViewItemWidge extends StatelessWidget {
  const PageViewItemWidge({
    super.key,
    required this.index,
    required this.slideAnimation,
    required this.rotationAnimation,
    required this.slideAnimation2,
  });
  final int index;
  final Animation<Offset> slideAnimation;
  final Animation<Offset> slideAnimation2;
  final Animation<double> rotationAnimation;
  @override
  Widget build(BuildContext context) {
    CupCakeModel cakeModel = DummyData.cupCakeList[index];
    return Stack(
      alignment: Alignment.center,
      children: [
        //*
        Center(
          child: Container(
            height: 200,
            margin: const EdgeInsets.only(top: 110),
            child: Image.asset(
              cakeModel.cupCakeImage,
              fit: BoxFit.cover,
            ),
          ),
        ),

        //*
        Container(
          alignment: Alignment.center,
          child: SlideTransition(
            position: slideAnimation,
            child: RotationTransition(
              turns: rotationAnimation,
              child: Image.asset(
                cakeModel.cupCakeTopImage,
              ),
            ),
          ),
        ),

        //*
        Container(
          alignment: Alignment.center,
          child: SlideTransition(
            position: slideAnimation2,
            child: RotationTransition(
              turns: rotationAnimation,
              child: Image.asset(
                cakeModel.cupCakeTopImage,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
