import 'package:ct312h_project/pages/ticket/tickerdetail_page.dart';
import 'package:ct312h_project/repositories/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TicketPage extends StatefulWidget {
  static const routeName = '/tickets';

  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TicketProvider>(context, listen: false).fetchTickets());
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    final tickets = ticketProvider.tickets;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List tickets',
          style: TextStyle(
            color: Color(0xffFF6969),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1A1A1D),
        ),
      body: 
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff1A1A1D),
                    Color(0xff131010)
                  ],
                ),
              ),
            ),
            ticketProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : tickets.isEmpty
                  ? const Center(child: Text('No ticket'))
                  : ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text(ticket.movieTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('ID ticket: ${ticket.id} • Date: ${ticket.date} • Time: ${ticket.time}'),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TicketDetailPage(ticketId: ticket.id),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
          ],
        ),
    );
  }
}
