// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/movieModel.dart';
// import '../providers/movieProvider.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final TextEditingController _controller = TextEditingController();

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   final provider = context.read<MovieProvider>();
//   //   provider.searchMovies("Avengers");

//   //   _scrollController.addListener(() {
//   //     final provider = context.read<MovieProvider>();
//   //     if (_scrollController.position.pixels >=
//   //             _scrollController.position.maxScrollExtent - 200 &&
//   //         !provider.isLoading &&
//   //         provider.hasMore) {
//   //       provider.searchMovies(
//   //           provider.movies.isEmpty ? "Avengers" : _controller.text,
//   //           reset: false);
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<MovieProvider>();

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: TextField(
//           controller: _controller,
//           style: TextStyle(color: Colors.white),
//           decoration: InputDecoration(
//             hintText: "Search Movie",
//             hintStyle: TextStyle(color: Colors.grey),
//             border: InputBorder.none,
//           ),
//           onSubmitted: (val) {
//             provider.searchMovies(val, reset: true);
//           },
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: provider.movies.isEmpty && !provider.isLoading
//           ? Center(
//               child: Text("No Movies Found",
//                   style: TextStyle(color: Colors.white)))
//           : GridView.builder(
//               controller: _scrollController,
//               padding: EdgeInsets.all(8),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.65,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemCount: provider.movies.length + (provider.isLoading ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index == provider.movies.length) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 final Movie movie = provider.movies[index];
//                 return Card(
//                   color: Colors.grey[900],
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Image.network(movie.poster,
//                             fit: BoxFit.cover, width: double.infinity),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(movie.title,
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(movie.year,
//                             style: TextStyle(color: Colors.grey)),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
