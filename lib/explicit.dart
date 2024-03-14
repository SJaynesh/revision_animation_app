import 'dart:math';

import 'package:flutter/material.dart';

class ExplicitAnimations extends StatefulWidget {
  const ExplicitAnimations({super.key});

  @override
  State<ExplicitAnimations> createState() => _ExplicitAnimationsState();
}

/*

    ExplicitAnimations:
     - must be handled with controller
     - all the widgets have Transition suffix
     - WidgetTransition
     - AnimatedBuilder
     - Staggered Animation:
        - applicable on different widgets only
        - animationObject = Tween(
            begin: start, end: stop,
          ).animate(
            CurvedAnimation(
              parent: AnimationController(),
              curve: Interval(
                begin, end,
              ),
            ),
          );

       - TweenChaining:
          - applicable on single widget only

*/

class _ExplicitAnimationsState extends State<ExplicitAnimations>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> turn1;
  late Animation<double> turn2;

  late AnimationController positionController;
  late Animation<double> x;
  late Animation<double> y;

  @override
  void initState() {
    animationController = AnimationController(
      //Current class instance - this
      //SingleTickerProviderStateMixin / TickerProviderStateMixin
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );

    turn1 = Tween(
      begin: 0.0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0,
          0.5,
        ),
      ),
    );
    turn2 = Tween(
      begin: 0.0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.5,
          1,
        ),
      ),
    );

    positionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    x = TweenSequence(
      [
        TweenSequenceItem<double>(
            tween: Tween(begin: -0.4, end: -0.5), weight: 1),
        TweenSequenceItem<double>(
            tween: Tween(begin: -0.5, end: -1), weight: 1),
        TweenSequenceItem<double>(tween: Tween(begin: -1, end: 0.5), weight: 1),
      ],
    ).animate(positionController);
    y = TweenSequence(
      [
        TweenSequenceItem<double>(tween: Tween(begin: 1, end: 0.1), weight: 1),
        TweenSequenceItem<double>(
            tween: Tween(begin: 0.1, end: -0.5), weight: 1),
        TweenSequenceItem<double>(
            tween: Tween(begin: -0.5, end: -1), weight: 1),
      ],
    ).animate(positionController);

    positionController.forward();

    super.initState();
  }

  //WidgetAnimation
  // RotationTransition(
  //   turns: animationController,
  //   child: const FlutterLogo(
  //     size: 150,
  //   ),
  // ),
  // //StaggeredAnimation
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //   children: [
  //     AnimatedBuilder(
  //       animation: turn1,
  //       builder: (context, _) => Transform.rotate(
  //         angle: turn1.value,
  //         child: const FlutterLogo(
  //           size: 100,
  //         ),
  //       ),
  //     ),
  //     AnimatedBuilder(
  //       animation: turn2,
  //       builder: (context, _) => Transform.rotate(
  //         angle: turn2.value,
  //         child: const FlutterLogo(
  //           size: 100,
  //         ),
  //       ),
  //     ),
  //   ],
  // ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explicit Animations"),
      ),
      body: AnimatedBuilder(
        animation: x,
        builder: (context, _) {
          return AnimatedBuilder(
            animation: y,
            builder: (context, _) {
              return Align(
                alignment: Alignment(x.value, y.value),
                child: const CircleAvatar(
                  radius: 60,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              animationController.reverse();
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              animationController.repeat();
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
            onPressed: () {
              animationController.forward();
            },
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
