import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobigic_task/res/widgets/icon_widget.dart';
import 'package:mobigic_task/res/widgets/text_widget.dart';
import 'package:mobigic_task/util/routes/routes_name.dart';
import 'package:mobigic_task/util/size_config.dart';
import 'package:mobigic_task/util/util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.home, (Route<dynamic> route) => false);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final Colours _colour = Colours();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: _colour.dark_blue,
      body: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            RotationTransition(
              turns: _animation,
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.30,
                  ),
                  IconWidget(color: _colour.white, size: 190),
                  TextWidget(
                      text: "Word Search Game",
                      textColor: _colour.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.35,
            ),
            TextWidget(
                text: "@Developed by PranavPaithankar",
                textColor: _colour.white,
                fontSize: 13,
                fontWeight: FontWeight.w100),
          ],
        ),
      ),
    );
  }
}
