import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housie_haven/home.dart';
import 'package:housie_haven/number_picker.dart';
import 'package:housie_haven/ticket_confirm.dart';
import 'package:housie_haven/player.dart';

void main() {
  runApp(const HousieApp());
}

class HousieApp extends StatelessWidget {
  const HousieApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Blomberg',
      ),
      initialRoute: 'home',
    routes: {
      'home': (context) => HomePage(),
      'number caller': (context) => HousieHomePage(),
      'tickets':(context) => const TicketsConfirmation(),
      'player':(context) => const Player(numberOfTickets: 0),
    },
    );
  }
}

