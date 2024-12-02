import 'package:flutter/cupertino.dart';

import '../../components/cards/ticketHistoryItem.dart';

class TicketHistoryList extends StatelessWidget {
  const TicketHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: TicketHistoryItem(),
        );
      },
    );
  }
}
