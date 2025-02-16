import 'package:flutter/cupertino.dart';
import 'package:housie_haven/player_ticket.dart';

class TicketGenerator extends StatelessWidget {
  final int numberOfTickets;

  const TicketGenerator({super.key, required this.numberOfTickets});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            numberOfTickets, (index) => PlayerTicket(ticketNumber: index + 1))
      ],
    );
  }
}
