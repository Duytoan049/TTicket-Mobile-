import 'package:ct312h_project/pages/movies/widgets/movie_backicon.dart';
import 'package:ct312h_project/repositories/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';


class TicketDetailPage extends StatefulWidget {
  final String ticketId;
  const TicketDetailPage({super.key, required this.ticketId});

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TicketProvider>(context, listen: false).fetchTicketById(widget.ticketId));
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<TicketProvider>(context);
    final ticket = ticketProvider.selectedTicket;

    return Scaffold(
      body: Stack(
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
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    'Ticket',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ticketProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ticket == null
                        ? const Center(child: Text('No ticket!'))
                        : Center(
                            child: Container(
                              width: 335,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(ticket.movieTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const Divider(),
                                    _ticketInfo('ID', ticket.id),
                                    _ticketInfo('Date', ticket.date, 'Time', ticket.time),
                                    _ticketInfo('Seat count', '${ticket.seatCount}'),
                                    _ticketInfo('Seats', ticket.seats.join(', ')),
                                    _ticketInfo(
                                      'Regular seat',
                                      '${NumberFormat("#,###", "vi_VN").format(ticket.ticketPrice)} VND',
                                    ),
                                    _ticketInfo(
                                      'Service charge',
                                      '${ticket.seatCount} x ${NumberFormat("#,###", "vi_VN").format(ticket.serviceCharge.toInt())} = ${NumberFormat("#,###", "vi_VN").format((ticket.seatCount * ticket.serviceCharge).toInt())} VND',
                                    ),
                                    _ticketInfo(
                                      'Total',
                                      '${NumberFormat("#,###", "vi_VN").format(ticket.totalPrice)} VND',
                                    ),
                                    const SizedBox(height: 20), // Khoảng cách trước mã QR
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: QrImageView(
                                        data: "${ticket.id} | ${ticket.movieTitle} | ${ticket.date} | ${ticket.time} | ${ticket.seats} | ${ticket.totalPrice}",
                                        version: QrVersions.auto,
                                        size: 120.0,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
            
                            ),
                          ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff00FF9C), // Màu nút
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          NavBack(),
        ],
      ),
    );
  }

  Widget _ticketInfo(String title, String value, [String? title2, String? value2]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                Text(value),
              ],
            ),
          ),
          if (title2 != null && value2 != null)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title2, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(value2),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
