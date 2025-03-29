import 'package:ct312h_project/repositories/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'widgets/movie_backicon.dart';
import '../../provider/movie_provider.dart';
// Import TicketProvider
import '../../model/ticket.dart'; // Import Ticket Model

class MovieTicketDetail extends StatefulWidget {
  final int movieId;
  final DateTime selectedDate;
  final String selectedTime;
  final String selectedSeats;
  final int totalPrice;
  final int ticketPrice;

  const MovieTicketDetail({
    super.key,
    required this.movieId,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedSeats,
    required this.totalPrice,
    required this.ticketPrice,
  });

  @override
  State<MovieTicketDetail> createState() => _MovieTicketDetailState();
}

class _MovieTicketDetailState extends State<MovieTicketDetail> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MovieProvider>(context, listen: false)
            .getMovieDetail(widget.movieId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;

    return Consumer2<MovieProvider, TicketProvider>(
      builder: (context, movieProvider, ticketProvider, child) {
        final movie = movieProvider.movieDetail;

        if (movie == null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Format ngày
        String displayDate =
            DateFormat('dd/MM/yyyy').format(widget.selectedDate); // Hiển thị
        String dbDate = DateFormat('yyyy-MM-dd')
            .format(widget.selectedDate); // Lưu vào database

        int seatCount = widget.selectedSeats.isEmpty
            ? 0
            : widget.selectedSeats.split(',').length;
        double serviceCharge = widget.ticketPrice * 0.06;
        int finalTotal =
            (widget.totalPrice + serviceCharge * seatCount).toInt();

        return Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff1A1A1D), Color(0xff131010)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      const Center(
                        child: Text(
                          'Ticket Detail',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 120),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: widthsize * 0.85,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Color(0xff00FF9C),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: widthsize * 0.5,
                                  child: Text(
                                    movie.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('MovieId: ${widget.movieId}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                Text('Date: $displayDate',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text('Time: ${widget.selectedTime}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                const SizedBox(height: 8),
                                Text(
                                    'Ticket ($seatCount): ${widget.selectedSeats}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                const SizedBox(height: 16),
                                const Text(
                                  'Transaction Detail',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(color: Colors.white),
                                Text(
                                  'REGULAR SEAT \n$seatCount x ${NumberFormat("#,###", "vi_VN").format(widget.ticketPrice)} VND',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Service Charge (6%)\n$seatCount x ${NumberFormat("#,###", "vi_VN").format(serviceCharge.toInt())} VND',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Divider(color: Colors.white),
                                Text(
                                  'Total payment\n${NumberFormat("#,###", "vi_VN").format(finalTotal)} VND',
                                  style: const TextStyle(
                                      color: Color(0xffFF6969),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -80,
                            right: -10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                movie.posterPath.isNotEmpty
                                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                                    : 'https://via.placeholder.com/150',
                                width: 120,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            // Tạo đối tượng TicketDetail
                            TicketDetail newTicket = TicketDetail(
                              id: '',
                              movieId: widget.movieId,
                              movieTitle: movie.title,
                              date: dbDate,
                              time: widget.selectedTime,
                              seatCount: seatCount,
                              seats: widget.selectedSeats.split(','),
                              ticketPrice: widget.ticketPrice,
                              serviceCharge: serviceCharge.toInt(),
                              totalPrice: finalTotal,
                            );
                  
                            // Gọi provider để thêm vé
                            await ticketProvider.addTicket(newTicket);
                  
                            // Kiểm tra lỗi
                            if (ticketProvider.errorMessage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Booking successful!",
                                      style: TextStyle(fontSize: 16)),
                                  backgroundColor: Color(0xff16C47F),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                  
                              // Chờ 2 giây rồi chuyển đến trang Home
                              Future.delayed(const Duration(seconds: 2), () {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Booking failed: ${ticketProvider.errorMessage}"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff00FF9C),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            "Confirm Booking",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const NavBack(),
            ],
          ),
        );
      },
    );
  }
}
