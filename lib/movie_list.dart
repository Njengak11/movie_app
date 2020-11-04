import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  Color mainColor = const Color(0xff3c3261);
  var movies;

  void getData() async { 
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( 
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading:Icon(Icons.arrow_back,
      color: mainColor,
      ),
      title: Text( 'Movies',
      style: TextStyle(color: mainColor,
      fontWeight: FontWeight.bold
      ),),
      actions: [
        Icon(
          Icons.menu,
          color: mainColor,
        )
      ],
      ),
      body: Padding( 
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieTile(mainColor),
            Expanded( 
              child:ListView.builder(
                itemCount: movies == null ? 0 : movies.length,
                itemBuilder:(context, i){ 
                  FlatButton( 
                    onPressed: (){ 
                      
                    },
                    child: MovieCell(movies, i),
                    padding: EdgeInsets.all(0),
                    color: Colors.white,
                  );
                }
                ),
            )
        ],),
      ),
    );
  }
}

Future<Map> getJson() async {
  var url = 'https://api.themoviedb.org/3/movie/550?api_key=c5b271887c8dbb7e832614fc6c836de5';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}

class MovieTile extends StatelessWidget {

  final Color mainColor;

  MovieTile(this.mainColor);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Text( 
        'Top Rated',style: TextStyle( 
          fontSize: 40,
          color: mainColor,
          fontWeight: FontWeight.bold
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCell extends StatelessWidget {

  final movies;
  final i;
  Color mainColor = Color(0xff3c3261);
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies, this.i);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Padding( 
            padding: EdgeInsets.all(0),
            child: Container( 
              margin: EdgeInsets.all(16),
              child: Container( 
                width: 70,
                height: 70,
              ),
              decoration: BoxDecoration( 
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
                image: DecorationImage(
                  image:NetworkImage( 
                    image_url+movies[i] ['poster_path']
                  ),
                  fit: BoxFit.cover
                   ),
                   boxShadow: [
                     BoxShadow(color: mainColor,
                     blurRadius: 5,
                     offset: Offset( 2.0,5.0)
                     )
                   ]
              ),
            ),
          ),
          Expanded( 
            child: Container( 
              margin: EdgeInsets.fromLTRB(16,0,16,0,),
              child: Column(children: [
                Text(movies[i] ['title'],
                style: TextStyle( 
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: mainColor
                ),
                ),
                Padding( 
                  padding: EdgeInsets.all(2),
                ),
                Text(movies[i]['overview'],
                maxLines: 3,
                style: TextStyle(color: Color(0xff8785A4),
                ),
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          )
        ],
        ),
        Container( 
          width: 300,
          height: 0.5,
          color: Color(0xD2D2E1ff),
          margin: EdgeInsets.all(16),
        )
      ],
    );
  }
}