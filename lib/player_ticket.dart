import 'package:flutter/material.dart';

class PlayerTicket extends StatefulWidget {
  final int ticketNumber;

  const PlayerTicket({super.key, required this.ticketNumber});

  @override
  State<PlayerTicket> createState() => _PlayerTicketState();
}

class _PlayerTicketState extends State<PlayerTicket> {
  final int rows = 3;
  final int columns = 9;
  final int numbersPerRow = 5;
  final arrNumbers = List.generate(27, (index) => index + 1);
  var nullPositions = [];
  var ticketNumbers = [];
  var clickedNumbers = <int, bool>{};

  void _generateTicket() {
    var rowOne = [1, 4, 7, 10, 13, 16, 19, 22, 25];
    var rowTwo = [2, 5, 8, 11, 14, 17, 20, 23, 26];
    var rowThree = [3, 6, 9, 12, 15, 18, 21, 24, 27];
    final invalidCombos = [
      [1, 4, 7],
      [4, 7, 10],
      [7, 10, 13],
      [10, 13, 16],
      [13, 16, 19],
      [16, 19, 22],
      [19, 22, 25],
      [1, 4, 7, 10],
      [4, 7, 10, 13],
      [7, 10, 13, 16],
      [10, 13, 16, 19],
      [13, 16, 19, 22],
      [16, 19, 22, 25],
      [2, 5, 8],
      [5, 8, 11],
      [8, 11, 14],
      [11, 14, 17],
      [14, 17, 20],
      [17, 20, 23],
      [20, 23, 26],
      [2, 5, 8, 11],
      [5, 8, 11, 14],
      [8, 11, 14, 17],
      [11, 14, 17, 20],
      [14, 17, 20, 23],
      [17, 20, 23, 26],
      [3, 6, 9],
      [6, 9, 12],
      [9, 12, 15],
      [12, 15, 18],
      [15, 18, 21],
      [18, 21, 24],
      [21, 24, 27],
      [3, 6, 9, 12],
      [6, 9, 12, 15],
      [9, 12, 15, 18],
      [12, 15, 18, 21],
      [15, 18, 21, 24],
      [18, 21, 24, 27]
    ];

    bool hasInvalidCombos;
    bool hasRecurringSets;

    do {
      nullPositions.clear();
      rowOne.shuffle();
      nullPositions.addAll(rowOne.sublist(0, 4));
      rowTwo.shuffle();
      nullPositions.addAll(rowTwo.sublist(0, 4));
      rowThree.shuffle();
      nullPositions.addAll(rowThree.sublist(0, 4));
      hasInvalidCombos = invalidCombos.any(
              (combo) => combo.every((number) => nullPositions.contains(number)));
      nullPositions.sort();
      hasRecurringSets = false;
      for (var i = 0; i < nullPositions.length - 2; i++) {
        if (nullPositions[i] + 1 == nullPositions[i + 1] &&
            nullPositions[i] + 2 == nullPositions[i + 2]) {
          hasRecurringSets = true;
          break;
        }
      }
    } while (hasInvalidCombos || hasRecurringSets);

    _generateTicketNumbers();
  }

  void _generateTicketNumbers() {
    ticketNumbers.clear();
    var numberGroups = [
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      [10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
      [20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
      [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
      [40, 41, 42, 43, 44, 45, 46, 47, 48, 49],
      [50, 51, 52, 53, 54, 55, 56, 57, 58, 59],
      [60, 61, 62, 63, 64, 65, 66, 67, 68, 69],
      [70, 71, 72, 73, 74, 75, 76, 77, 78, 79],
      [80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90],
    ];

    for (var group in numberGroups) {
      group.shuffle();
      ticketNumbers.addAll(group.sublist(0, 3));
    }

    ticketNumbers.sort();
  }

  void _toggleNumber(int number) {
    setState(() {
      if (nullPositions.contains(number)) {
        return; // Do not toggle on null positions
      }
      clickedNumbers[number] = !(clickedNumbers[number] ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    _generateTicket();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius:
        BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            height: 30,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.tealAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: Text(
              '  Ticket ${widget.ticketNumber} :',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            height: 140,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.tealAccent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: rows * columns,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rows,
                  ),
                  itemBuilder: (context, index) {
                    final number = arrNumbers[index];
                    final ticketNumber = ticketNumbers[index];
                    final isNullPosition =
                    nullPositions.contains(number);
                    final isClicked =
                        clickedNumbers[number] ?? false;

                    return GestureDetector(
                      onTap: () => _toggleNumber(number),
                      child: Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(0.5),
                        child: Stack(
                          children: [
                            Container(
                              color: isNullPosition
                                  ? Colors.lightBlueAccent
                                  : Colors.limeAccent,
                              child: Center(
                                child: isNullPosition
                                    ? null
                                    : Text(ticketNumber.toString()),
                              ),
                            ),
                            if (isClicked && !isNullPosition)
                              const Center(
                                child: Text(
                                  'X',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
