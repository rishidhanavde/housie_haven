import 'package:flutter/material.dart';
import 'package:housie_haven/player.dart';

class TicketsConfirmation extends StatefulWidget {
  const TicketsConfirmation({super.key});

  @override
  State<TicketsConfirmation> createState() => _TicketsConfirmationState();
}

class _TicketsConfirmationState extends State<TicketsConfirmation> {
  Color gradient1 = const Color(0xFF8C52FF);
  Color gradient2 = const Color(0xFF5CE1E6);
  bool isDialogBoxOn = true;
  double _sliderValue = 1.0;

  void toggleDialogBox() {
    setState(() {
      isDialogBoxOn = !isDialogBoxOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [gradient1, gradient2])),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: isDialogBoxOn
              ? Colors.black26.withOpacity(0.6)
              : Colors.transparent,
          child: Center(
            child: isDialogBoxOn
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    height: 280,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.8,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'Tickets Count',
                            style: TextStyle(fontSize: 30),
                          ),
                          const Text(
                            'Select the number of Tickets you want to play with',
                          ),
                          Slider(
                              value: _sliderValue,
                              min: 1,
                              max: 12,
                              divisions: 11,
                              label: _sliderValue.toInt().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _sliderValue = value;
                                });
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('CANCEL')),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Player(
                                        numberOfTickets: _sliderValue.toInt(),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('START'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 500,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Please wait...'),
                          const SizedBox(height: 15),
                          const CircularProgressIndicator(),
                          const SizedBox(height: 15),
                          if (_sliderValue == 1)
                            const Text('while we make your ticket')
                          else
                            const Text('while we make your tickets')
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
