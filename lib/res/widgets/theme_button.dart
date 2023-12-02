import 'package:flutter/material.dart';
import 'package:mobigic_task/util/util.dart';
import 'package:mobigic_task/view_model/themeProvider.dart';
import 'package:provider/provider.dart';

bool lightmode = true;

class ThemeButton extends StatefulWidget {
  const ThemeButton({super.key});

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

Colours _colour = Colours();

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, themeChange, Widget? child) {
        return SizedBox(
          height: 40,
          width: 40,
          child: CircleAvatar(
            radius: 5,
            backgroundColor:
                themeChange.lightmode ? _colour.yellow : _colour.blue,
            child: IconButton(
              onPressed: () {
                themeChange.setchange();
              },
              icon: Icon(
                themeChange.lightmode ? Icons.nightlight : Icons.wb_sunny,
                size: 20,
                color: themeChange.lightmode ? _colour.blue : _colour.yellow,
              ),
            ),
          ),
        );
      },
    );
  }
}
