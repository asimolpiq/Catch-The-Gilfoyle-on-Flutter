import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CatchTheGilfoyle extends StatefulWidget {
  CatchTheGilfoyle({Key? key}) : super(key: key);

  @override
  State<CatchTheGilfoyle> createState() => _CatchTheGilfoyleState();
}

class _CatchTheGilfoyleState extends State<CatchTheGilfoyle> {
  late List<_head> _headList;
  Timer? countdown;
  Timer? changer;
  int second = 30;

  void countdownTimer() {
    countdown = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        second--;
      });
      if (second == 0) timer.cancel();
    });
  }

  void headChanger() {
    changer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      _headList.clear();
      _headList = List.generate(9, (index) => _head());
      setState(() {
        _headList[Random().nextInt(9)].visibility = true;
      });

      if (second == 0) timer.cancel();
    });
  }

  void playAgain() {
    scoreUtility.score = 0;
    Navigator.pop(context);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CatchTheGilfoyle(),
    ));
  }

  @override
  void initState() {
    super.initState();
    _headList = List.generate(9, (index) => _head());
    countdownTimer();
    headChanger();
  }

  @override
  Widget build(BuildContext context) {
    String _appbarTitle = 'Catch The Gilfoyle';

    return Scaffold(
      appBar: AppBar(
        title: Text(_appbarTitle),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Second: $second",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return _headList[index];
              },
            ),
          ),
          Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "Score: ${scoreUtility.score}",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ))
        ],
      ),
      floatingActionButton: Visibility(
          visible: second == 0,
          child: FloatingActionButton.extended(
            onPressed: playAgain,
            label: Text("Play Again"),
            backgroundColor: Colors.blue,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class _head extends StatefulWidget {
  bool visibility;

  _head({
    Key? key,
    this.visibility = false,
  }) : super(key: key);

  @override
  State<_head> createState() => _headState();
}

class _headState extends State<_head> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (widget.visibility) scoreUtility().addScore();
      },
      child: Visibility(
        child: Image.asset(
          "assets/gilfoyle.png",
        ),
        visible: widget.visibility,
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      enableFeedback: false,
    );
  }
}

class scoreUtility {
  static int score = 0;
  void addScore() {
    score++;
  }
}
