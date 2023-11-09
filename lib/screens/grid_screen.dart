import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class GridScreen extends StatefulWidget {
  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  int m = 0;
  int n = 0;
  List<List<String>> grid = [];

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
      case 0: // east
        dx = 1;
        break;
      case 1: // south
        dy = 1;
        break;
      case 2: // southeast
        dx = 1;
        dy = 1;
        break;
      // Add other directions if needed
    }

    int wordLength = word.length;
    if (row + dy * (wordLength - 1) >= m || col + dx * (wordLength - 1) >= n) {
      return false; // Word can't fit in this direction
    }

    for (int i = 0; i < wordLength; i++) {
      if (grid[row + i * dy][col + i * dx] != word[i]) {
        return false; // Mismatched character found
      }
    }
    return true; // Word found in this direction
  }

  void highlight(int row, int col, String word, int direction) {
    int dx = 0, dy = 0;
    switch (direction) {
      case 0: // east
        dx = 1;
        break;
      case 1: // south
        dy = 1;
        break;
      case 2: // southeast
        dx = 1;
        dy = 1;
        break;
      // Add other directions if needed
    }

    for (int i = 0; i < word.length; i++) {
      highlightedCells[row + i * dy][col + i * dx] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.blue[200],
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              width: 45,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.eco_rounded,
                  color: Colors.purple,
                  size: 35,
                ),
              ),
            ),
            // ignore: deprecated_member_use
            TypewriterAnimatedTextKit(
              text: ['Word Search Game'],
              textStyle: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              speed: Duration(milliseconds: 200),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter grid dimensions Row(m) and Column(n) : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Row(m): ",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      //style button start
                      decoration: InputDecoration(
                        labelText: 'Row(m)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ), //style button end
                      onChanged: (value) {
                        m = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Column(n): ",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: TextField(
                      //style button start
                      decoration: InputDecoration(
                        labelText: 'Column(n)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ), //style button end
                      onChanged: (value) {
                        n = int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  if (m > 0 && n > 0) {
                    createGrid();
                    setState(() {});
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                  textStyle: TextStyle(fontSize: 15),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text("Create Grid"),
              ),
              SizedBox(
                height: 30,
              ),
              if (grid.isNotEmpty)
                Column(
                  children: <Widget>[
                    Text(
                      "Enter alphabets for the grid:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
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
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ), //style button end
                                    onChanged: (value) {
                                      grid[i][j] = value;
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        primary: Colors.white,
                        textStyle: TextStyle(fontSize: 15),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text("Create Grid"),
                    ),
                  ],
                ),
              SizedBox(
                height: 30,
              ),
              if (grid.isNotEmpty)
                Column(
                  children: <Widget>[
                    Text(
                      "Enter a word to search:",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 180,
                          child: TextField(
                            decoration: InputDecoration(
                              icon: new Icon(Icons.search),
                              labelText: "Search Alphabets",
                            ),
                            onChanged: (value) {
                              searchText = value;
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            searchAndHighlight();
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            primary: Colors.white,
                            textStyle: TextStyle(fontSize: 15),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text("Search"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    if (searchText.isNotEmpty)
                      Text(
                        "Highlighted Grid:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    SizedBox(
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
              SizedBox(
                height: 30,
              ),
              if (grid.isNotEmpty && searchText.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      highlightedCells = List.generate(
                          m, (i) => List.generate(n, (j) => false));
                      searchText = '';
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 15),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text("Clear Search"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
