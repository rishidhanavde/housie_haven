import 'package:flutter/material.dart';
import 'package:housie_haven/ticket_confirm.dart';
import 'package:housie_haven/ticket_generator.dart';

class Player extends StatefulWidget {
  final int numberOfTickets;

  const Player({
    Key? key,
    required this.numberOfTickets,
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  Color gradient1 = const Color(0xFF8C52FF);
  Color gradient2 = const Color(0xFF5CE1E6);
  bool isBottomContainerUp = false;
  bool isJaldi5Clicked = false;
  bool isCornerClicked = false;
  bool isTopLineClicked = false;
  bool isMiddleLineClicked = false;
  bool isBottomLineClicked = false;
  bool isFullHouseClicked = false;

  void showRestartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Restart Game'),
          content: const Text('Do you want to restart game?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  isFullHouseClicked = false;
                  setState(() {});
                },
                child: const Text('CANCEL')),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicketsConfirmation(),
                    ),
                  );
                },
                child: const Text('START')),
          ],
        );
      },
    );
  }

  void _jaldi5Clicking() {
    setState(() {
      isJaldi5Clicked = !isJaldi5Clicked;
    });
  }

  void _cornerClicking() {
    setState(() {
      isCornerClicked = !isCornerClicked;
    });
  }

  void _topLineClicking() {
    setState(() {
      isTopLineClicked = !isTopLineClicked;
    });
  }

  void _middleLineClicking() {
    setState(() {
      isMiddleLineClicked = !isMiddleLineClicked;
    });
  }

  void _bottomLineClicking() {
    setState(() {
      isBottomLineClicked = !isBottomLineClicked;
    });
  }

  void _fullHouseClicking() {
    if (!isJaldi5Clicked ||
        !isCornerClicked ||
        !isTopLineClicked ||
        !isMiddleLineClicked ||
        !isBottomLineClicked) {
      return;
    }
    setState(() {
      isFullHouseClicked = !isFullHouseClicked;
    });
    showRestartDialog(context);
  }

  void _toggleBottomContainer() {
    setState(() {
      isBottomContainerUp = !isBottomContainerUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradient1, gradient2])),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 100),
                  TicketGenerator(numberOfTickets: widget.numberOfTickets),
                  const SizedBox(height: 100)
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: isBottomContainerUp ? 0 : -200,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: _toggleBottomContainer,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomRight,
                            colors: [gradient2, gradient1]),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Remaining Prizes',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            width: double.maxFinite,
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 20,
                                  children: [
                                    isJaldi5Clicked
                                        ? OutlinedButton(
                                            onPressed: () => _jaldi5Clicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text(
                                              'Jaldi 5',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () => _jaldi5Clicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text('Jaldi 5'),
                                          ),
                                    isCornerClicked
                                        ? OutlinedButton(
                                            onPressed: () => _cornerClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text(
                                              'Corner',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () => _cornerClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text('Corner'),
                                          ),
                                    isTopLineClicked
                                        ? OutlinedButton(
                                            onPressed: () => _topLineClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text(
                                              'Top Line',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () => _topLineClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text('Top Line'),
                                          ),
                                    isMiddleLineClicked
                                        ? OutlinedButton(
                                            onPressed: () =>
                                                _middleLineClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text(
                                              'Middle Line',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () =>
                                                _middleLineClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text('Middle Line'),
                                          ),
                                    isBottomLineClicked
                                        ? OutlinedButton(
                                            onPressed: () =>
                                                _bottomLineClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text(
                                              'Bottom Line',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () =>
                                                _bottomLineClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text('Bottom Line'),
                                          ),
                                    isFullHouseClicked
                                        ? OutlinedButton(
                                            onPressed: () =>
                                                _fullHouseClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text(
                                              'Full House',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () =>
                                                _fullHouseClicking(),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              minimumSize: const Size(120, 40),
                                            ),
                                            child: const Text('Full House'),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                        radius: 20,
                        child: Icon(
                          isBottomContainerUp
                              ? Icons.keyboard_arrow_down_rounded
                              : Icons.keyboard_arrow_up_rounded,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
