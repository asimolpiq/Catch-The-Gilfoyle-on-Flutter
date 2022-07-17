// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class CatchGilfoyle extends StatefulWidget {
  CatchGilfoyle({Key? key}) : super(key: key);

  @override
  State<CatchGilfoyle> createState() => _CatchGilfoyleState();
}

class _CatchGilfoyleState extends State<CatchGilfoyle> {
  static const maxSecond = 30;
  int score = 0;
  int second = maxSecond;
  Timer? countdown;
  Timer? changer;
  List<_head> _headsList = List.generate(9, (index) => _head());

  void CountdownTimer() {
    countdown = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        second--;
      });
      if (second == 0) {
        timer.cancel();
      }
    });
  }

  void headChanger() {
    changer = Timer.periodic(Duration(milliseconds: 400), (timer) {
      _headsList.clear();
      _headsList = List.generate(9, (index) => _head());
      if (second == 0) {
        timer.cancel();
      }
      setState(() {
        for (_head i in _headsList) {
          i.visibility = false;
        }
        _headsList[Random().nextInt(9)].visibility = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    CountdownTimer();
    headChanger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catch The Gilfoyle"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Time : $second",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              physics: ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return _headsList[index];
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                "Score : ${utilitys.score}",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: second == 0,
        child: FloatingActionButton.extended(
          onPressed: (() {
            utilitys.score = 0;
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CatchGilfoyle()));
          }),
          backgroundColor: Colors.blue,
          label: Text("Play Again"),
        ),
      ),
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
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (widget.visibility) utilitys().addScore();
        });
      },
      child: Visibility(visible: widget.visibility, child: Image.asset("assets/png/gilfoyle.png")),
      style: ElevatedButton.styleFrom(primary: Colors.transparent, fixedSize: Size(100, 100)),
    );
  }
}

class utilitys {
  static int score = 0;
  void addScore() {
    score++;
  }
}
