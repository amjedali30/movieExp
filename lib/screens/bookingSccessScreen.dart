import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:ticket_widget/ticket_widget.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Success Icon
                Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade100,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(Icons.check, color: Colors.green, size: 60),
                ),

                // ✅ Title
                const Text(
                  "Booking Successful",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),
                const Text(
                  "For Avengers",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 30),

                // 🎟 Ticket Widget
                TicketWidget(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 500,
                  color: const Color.fromARGB(255, 246, 240, 240),
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Poster
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Image.asset(
                          "assets/image/onbImg2.jpg",
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Movie Details
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Doctor Strange in the Multiverse of Madness",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Date: April 23"),
                                  Text("Time: 6 p.m."),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Row: 2"),
                                  Text("Seats: 9, 10"),
                                ],
                              ),
                              const Spacer(),

                              // ✅ Barcode
                              BarcodeWidget(
                                barcode: Barcode.code128(),
                                data: "TICKET-2025-AVENGERS-ROW2-9-10",
                                width: double.infinity,
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
