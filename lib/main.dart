import 'dart:math';

import 'package:flutter/material.dart';
import 'package:revision_animation_app/explicit.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExplicitAnimations(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/*

    Implicit Animation:
      - can be handled without animation controller.
      - all the widgets will have Animated as prefix.
      - AnimatedWidgets
      - TweenAnimationBuilder() & Tween() class



*/

class _HomePageState extends State<HomePage> {
  int s = 0;
  double opacity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                s++;
                setState(() {});
              },
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 150,
                width: 150,
                color: Colors.primaries[s % 18],
              ),
            ),
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 3),
              child: GestureDetector(
                onTap: () {
                  if (opacity == 0) {
                    opacity = 1;
                  } else {
                    opacity = 0;
                  }
                  setState(() {});
                },
                child: const FlutterLogo(
                  size: 150,
                ),
              ),
            ),
            //Automatic
            //Splash Screen
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: pi),
              duration: const Duration(seconds: 3),
              builder: (context, value, _) {
                return Transform.rotate(
                  angle: value,
                  child: const FlutterLogo(
                    size: 150,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ExplicitAnimations(),
            ),
          );
        },
      ),
    );
  }
}
