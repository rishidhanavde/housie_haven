import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class HousieHomePage extends StatefulWidget {
  @override
  _HousieHomePageState createState() => _HousieHomePageState();
}

class _HousieHomePageState extends State<HousieHomePage> {
  Color gradient1 = Color(0xFF8C52FF);
  Color gradient2 = Color(0xFF5CE1E6);
  List<int> calledNumbers = [];
  int currentNumber = 0;
  Timer? timer;
  bool isTimerOn = false;
  List<int> timers = [3, 4, 5]; // Available timer durations
  int selectedTimer = 3;
  final arrNumbers = List.generate(90, (index) => index + 1);
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void generateNumber() {
    setState(() {
      if (calledNumbers.length == 90) {
        Fluttertoast.showToast(
          msg: 'Starting New Game.\nAll numbers generated.',
          gravity: ToastGravity.BOTTOM,
        );
        resetGame();
        return;
      }

      do {
        currentNumber = Random().nextInt(90) + 1;
      } while (calledNumbers.contains(currentNumber));
      calledNumbers.add(currentNumber);
    });
  }

  void resetGame() {
    setState(() {
      calledNumbers.clear();
      currentNumber = 0;
    });
  }

  void startGeneratingNumbers() {
    timer = Timer.periodic(Duration(seconds: selectedTimer), (timer) {
      generateNumber();
      if (calledNumbers.length == 90) {
        stopGeneratingNumbers();
      }
    });
    setState(() {
      isTimerOn = true;
    });
  }

  void stopGeneratingNumbers() {
    timer?.cancel();
    setState(() {
      isTimerOn = false;
    });
  }

  void showTimerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Timer'),
          backgroundColor: Colors.cyanAccent,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Select a timer duration:'),
                  const SizedBox(height: 8),
                  DropdownButton<int>(
                    value: selectedTimer,
                    items: timers.map((timer) {
                      return DropdownMenuItem<int>(
                        value: timer,
                        child: Text('$timer seconds'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTimer = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('CANCEL')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startGeneratingNumbers();
                },
                child: const Text('START')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => showTimerDialog(context),
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.timer_sharp)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradient1, gradient2])),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [gradient2, gradient1]),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                        color: Colors.black,
                        width: 0.8,
                      )),
                  child: Center(
                    child: Container(
                      height: 120,
                      width: 120,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.8,
                          )),
                      child: Center(
                        child: Text(
                          currentNumber != 0 ? currentNumber.toString() : '---',
                          style: const TextStyle(
                              fontSize: 80, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(30),
                height: 302,
                decoration: BoxDecoration(
                    color: Colors.tealAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.8,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: GridView.builder(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        final number = arrNumbers[index];
                        final isGenerated = calledNumbers.contains(number);
                        return Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(0.5),
                            child: Container(
                              color: isGenerated
                                  ? Colors.lightBlueAccent
                                  : Colors.white,
                              child: Center(
                                child: Text(
                                  number.toString(),
                                  style: TextStyle(
                                    fontWeight: isGenerated
                                        ? FontWeight.w500
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: arrNumbers.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10),
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ),
            ),
            if (!isTimerOn)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: generateNumber,
                    child: Text('  Generate Number  ',
                        style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(0, 40),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: resetGame,
                    child: Text('  Reset The Game  ',
                        style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: Size(0, 40),
                    ),
                  ),
                ],
              ),
            if (isTimerOn)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        onPressed: stopGeneratingNumbers,
                        child: Text('Stop', style: TextStyle(fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: Size(0, 40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
