import 'package:flutter/material.dart';
import 'package:movie_explorer/screens/bookingSccessScreen.dart';
import 'package:provider/provider.dart';
import '../providers/movieProvider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbID;
  const MovieDetailScreen({super.key, required this.imdbID});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  final List<String> dates = [
    "12 Fri",
    "13 Sat",
    "14 Sun",
    "15 Mon",
    "16 Tue",
    "17 Thu",
    "18 Fri"
  ];
  final List<String> times = ["09:40 AM", "11:40 AM", "02:00 PM", "04:30 PM"];

  @override
  void initState() {
    super.initState();
    Provider.of<MovieProvider>(context, listen: false)
        .fetchMovieDetail(widget.imdbID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<MovieProvider>(
        builder: (context, provider, _) {
          if (provider.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          final detail = provider.details;
          if (detail == null) {
            return const Center(
              child: Text("Failed to load details",
                  style: TextStyle(color: Colors.white)),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Poster + Trailer Button
                Stack(
                  children: [
                    Image.network(
                      detail.poster,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text("Watch Trailer",
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 16),

                /// Chips Row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      _chip(detail.genre),
                      _chip("UA16+"),
                      _chip(detail.language),
                      _chip(detail.runtime),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    detail.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// Plot
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    detail.plot,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 14, height: 1.5),
                  ),
                ),

                const SizedBox(height: 16),

                /// Cast Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      _castCard("Robert Downey Jr.", "Tony Stark / Iron Man"),
                      const SizedBox(width: 12),
                      _castCard("Scarlett Johansson",
                          "Natasha Romanoff / Black Widow"),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// Date Selector (Horizontal Scroll)
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: dates.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedDateIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedDateIndex = index);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Center(
                            child: Text(
                              dates[index],
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                /// Time Slots
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    spacing: 12,
                    children: List.generate(times.length, (index) {
                      final isSelected = selectedTimeIndex == index;
                      return ChoiceChip(
                        label: Text(times[index]),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() => selectedTimeIndex = index);
                        },
                        selectedColor: Colors.red,
                        backgroundColor: Colors.grey[850],
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 30),

                /// Book Now Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingSuccessScreen()));
                      },
                      child: const Text(
                        "BOOK NOW",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _chip(String label) {
    return Chip(
      backgroundColor: Colors.grey[850],
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _castCard(String name, String role) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 4),
            Text(role,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
