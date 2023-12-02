import 'package:flutter/material.dart';
import 'package:mobigic_task/res/widgets/icon_widget.dart';
import 'package:mobigic_task/res/widgets/text_widget.dart';
import 'package:mobigic_task/res/widgets/theme_button.dart';
import 'package:mobigic_task/util/routes/routes_name.dart';
import 'package:mobigic_task/view_model/themeProvider.dart';
import 'package:provider/provider.dart';
import '../util/size_config.dart';
import '../util/util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Colours _colour = Colours();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, themeChange, Widget? child) {
        return Scaffold(
          backgroundColor:
              themeChange.lightmode ? _colour.white : _colour.dark_blue,
          body: SafeArea(
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  SizedBox(
                    child: IconWidget(
                      color:
                          themeChange.lightmode ? _colour.blue : _colour.white,
                      size: 200,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: TextWidget(
                      text: "Word Search Game",
                      textColor:
                          themeChange.lightmode ? _colour.blue : _colour.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: themeChange.lightmode
                              ? _colour.dark_blue.withOpacity(0.8)
                              : _colour.white.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.grid);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: _colour.dark_blue,
                        backgroundColor: _colour.yellow,
                        textStyle: const TextStyle(fontSize: 30),
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: TextWidget(
                        text: "Start Game",
                        textColor: _colour.blue,
                        fontSize: 35,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: ThemeButton(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        );
      },
    );
  }
}
