import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_task/res/widgets/theme_button.dart';
import 'package:mobigic_task/view_model/themeProvider.dart';
import 'package:provider/provider.dart';
import '../res/widgets/icon_widget.dart';
import '../res/widgets/text_widget.dart';
import '../util/size_config.dart';
import '../util/util.dart';

class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

Colours _colour = Colours();

class _GridScreenState extends State<GridScreen> {
  int m = 0;
  int n = 0;
  List<List<String>> grid = [];
  bool gridvalue = false;

  String searchText = '';
  List<List<bool>> highlightedCells = [];

  void createGrid() {
    grid = List.generate(m, (i) => List.generate(n, (j) => ""));
    highlightedCells = List.generate(m, (i) => List.generate(n, (j) => false));
  }

  void searchAndHighlight() {
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        for (int direction = 0; direction < 8; direction++) {
          if (search(i, j, searchText, direction)) {
            highlight(i, j, searchText, direction);
          }
        }
      }
    }
  }

  bool search(int row, int col, String word, int direction) {
    int dx = 0, dy = 0;
    switch (direction) {
      case 0:
        dx = 1;
        break;
      case 1:
        dy = 1;
        break;
      case 2:
        dx = 1;
        dy = 1;
        break;
    }

    int wordLength = word.length;
    if (row + dy * (wordLength - 1) >= m || col + dx * (wordLength - 1) >= n) {
      return false;
    }

    for (int i = 0; i < wordLength; i++) {
      if (grid[row + i * dy][col + i * dx] != word[i]) {
        return false;
      }
    }
    return true;
  }

  void highlight(int row, int col, String word, int direction) {
    int dx = 0, dy = 0;
    switch (direction) {
      case 0:
        dx = 1;
        break;
      case 1:
        dy = 1;
        break;
      case 2:
        dx = 1;
        dy = 1;
        break;
    }

    for (int i = 0; i < word.length; i++) {
      highlightedCells[row + i * dy][col + i * dx] = true;
    }
  }

  String? gridTextValidator(String value) {
    if (value.length != 1 || !RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return 'Enter one alphabet character only';
    }
    return null;
  }

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
              padding: const EdgeInsets.all(15),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.1,
                              child: IconWidget(
                                  color: themeChange.lightmode
                                      ? _colour.blue
                                      : _colour.white,
                                  size: 40),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.8,
                              child: TextWidget(
                                  text: "Word Search Game",
                                  textColor: themeChange.lightmode
                                      ? _colour.blue
                                      : _colour.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 20,
                        thickness: 0.2,
                        indent: 20,
                        endIndent: 0,
                        color: themeChange.lightmode
                            ? _colour.blue
                            : _colour.white,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextWidget(
                          text: " Enter grid dimensions Row and Column : ",
                          textColor: themeChange.lightmode
                              ? _colour.blue
                              : _colour.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextWidget(
                              text: "Row : ",
                              textColor: themeChange.lightmode
                                  ? _colour.blue
                                  : _colour.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              //style button start
                              decoration: InputDecoration(
                                labelText: 'Row',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: themeChange.lightmode
                                        ? _colour.blue
                                        : _colour.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ), //style button end
                              onChanged: (value) {
                                // ignore: unused_local_variable

                                n = int.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          TextWidget(
                              text: "Column : ",
                              textColor: themeChange.lightmode
                                  ? _colour.blue
                                  : _colour.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                          SizedBox(
                            width: 80,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              //style button start
                              decoration: InputDecoration(
                                labelText: 'Column',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: themeChange.lightmode
                                        ? _colour.blue
                                        : _colour.white,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ), //style button end
                              onChanged: (value) {
                                m = int.tryParse(value) ?? 0;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
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
                            if (m > 0 && n > 0) {
                              createGrid();
                              setState(() {});
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _colour.yellow,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: TextWidget(
                              text: "Create Grid",
                              textColor: _colour.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Divider(
                        height: 20,
                        thickness: 0.2,
                        indent: 20,
                        endIndent: 0,
                        color: themeChange.lightmode
                            ? _colour.blue
                            : _colour.white,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (grid.isNotEmpty)
                        Column(
                          children: <Widget>[
                            TextWidget(
                                text: " Enter alphabets for the grid: ",
                                textColor: themeChange.lightmode
                                    ? _colour.blue
                                    : _colour.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 30,
                            ),
                            for (int i = 0; i < m; i++)
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      for (int j = 0; j < n; j++)
                                        SizedBox(
                                          width: 40,
                                          child: TextField(
                                            //style button start
                                            decoration: InputDecoration(
                                              labelText: 'Column(n)',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.blue),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ), //style button end
                                            onChanged: (value) {
                                              String? validationResult =
                                                  gridTextValidator(value);
                                              if (validationResult == null) {
                                                grid[i][j] = value;
                                                setState(() {
                                                  gridvalue = true;
                                                });
                                              } else {
                                                setState(() {
                                                  gridvalue = false;
                                                });
                                                // Show an error message if validation fails
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content:
                                                        Text(validationResult),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(
                              height: 25,
                            ),
                            Divider(
                              height: 20,
                              thickness: 0.2,
                              indent: 20,
                              endIndent: 0,
                              color: themeChange.lightmode
                                  ? _colour.blue
                                  : _colour.white,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      if (grid.isNotEmpty && gridvalue == true)
                        Column(
                          children: <Widget>[
                            TextWidget(
                                text: "Enter a word to search: ",
                                textColor: themeChange.lightmode
                                    ? _colour.blue
                                    : _colour.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 180,
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.search),
                                      labelText: "Search Alphabets",
                                    ),
                                    onChanged: (value) {
                                      searchText = value;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
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
                                      searchAndHighlight();
                                      setState(() {});
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: _colour.yellow,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: TextWidget(
                                        text: "Search",
                                        textColor: _colour.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Divider(
                              height: 20,
                              thickness: 0.2,
                              indent: 20,
                              endIndent: 0,
                              color: themeChange.lightmode
                                  ? _colour.blue
                                  : _colour.white,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            if (searchText.isNotEmpty && gridvalue == true)
                              TextWidget(
                                  text: "Highlighted Grid: ",
                                  textColor: themeChange.lightmode
                                      ? _colour.blue
                                      : _colour.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            const SizedBox(
                              height: 30,
                            ),
                            for (int i = 0; i < m; i++)
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int j = 0; j < n; j++)
                                      Container(
                                        width: 30,
                                        height: 30,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: highlightedCells[i][j]
                                              ? Colors.yellow
                                              : Colors.blue,
                                        ),
                                        child: Text(
                                          grid[i][j],
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue[900],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (grid.isNotEmpty && searchText.isNotEmpty)
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
                              setState(() {
                                highlightedCells = List.generate(
                                    m, (i) => List.generate(n, (j) => false));
                                searchText = '';
                              });
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: _colour.yellow,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: TextWidget(
                                text: "Clear Search",
                                textColor: _colour.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
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
