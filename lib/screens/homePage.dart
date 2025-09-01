import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_explorer/providers/movieProvider.dart';
import 'package:movie_explorer/screens/movieDetails.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MovieProvider>(context, listen: false).fetchTrending();
  }

  List genres = [
    "assets/image/action.jpeg",
    "assets/image/horror.jpeg",
    "assets/image/science.png"
  ];
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<MovieProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF16213E),
                Color(0xFF0F3460),
                Color(0xFF533483),
              ],
            ),
          ),
          child: Stack(
            children: [
              Image(image: AssetImage("assets/image/onbImg1.jpg")),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(25),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: TextField(
                          // controller: _searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search Movie',
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.search,
                                color: Colors.white.withOpacity(0.6)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                          // onSubmitted: (query) {
                          //   if (query.isNotEmpty) {
                          //     _searchMovies(query, 1);
                          //   }
                          // },
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(.2)),
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Drama",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "12+",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Drama",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 13 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.6,
                      ),
                      items: movie.trending.map((movieItem) {
                        print(movieItem.imdbID);
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Image.network(
                                    movieItem.poster,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/image/placeHilderImg.jpeg",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    },
                                  ),

                                  /// Overlay Gradient
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                      bottom: 0,
                                      // left: 20,
                                      // right: 20,
                                      child: GestureDetector(
                                        onTap: () {
                                          print(movieItem.imdbID);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MovieDetailScreen(
                                                        imdbID:
                                                            movieItem.imdbID,
                                                      )));
                                        },
                                        child: Container(
                                            height: 50,
                                            width: 250,
                                            color: const Color.fromARGB(
                                                255, 25, 16, 16),
                                            child: Center(
                                              child: Text(
                                                "Book Now",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )),
                                      )),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Trending Movies Near You",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: genres.length,
                        itemBuilder: (context, index) {
                          final movieItem = movie.trending[index];

                          return Container(
                            width: 300, // control item width
                            margin: const EdgeInsets.only(
                                right: 12), // spacing between items
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    movieItem.poster,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        genres[index],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Upcomming ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movie.trending.length,
                        itemBuilder: (context, index) {
                          final movieItem = movie.trending[index];

                          return Container(
                            width: 200,
                            margin: const EdgeInsets.only(
                                right: 12), // spacing between items
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  Image.network(
                                    movieItem.poster,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/image/placeHilderImg.jpeg",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      );
                                    },
                                  ),

                                  /// Overlay Gradient
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                      bottom: 0,
                                      // left: 20,
                                      // right: 20,
                                      child: Container(
                                          height: 50,
                                          width: 200,
                                          color: const Color.fromARGB(
                                              255, 25, 16, 16),
                                          child: Center(
                                            child: Text(
                                              "Book Now",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
