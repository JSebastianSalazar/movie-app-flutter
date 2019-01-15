import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.model.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/results.model.dart';
import 'package:intl/intl.dart';

const baseUrl = "https://api.themoviedb.org/3/movie/";
const baseUrlImage = "https://image.tmdb.org/t/p/";
const apikey = "4f843d6d803eef3464b55ea6e71e1890";
const nowPlaying = "${baseUrl}now_playing?api_key=$apikey";
const upCommingURL = "${baseUrl}upcoming?api_key=$apikey";
const popularURL = "${baseUrl}popular?api_key=$apikey";
const topRateURL = "${baseUrl}top_rated?api_key=$apikey";
const NOWPLAYLIST = "EN LISTA AHORA";
const PELITITULO = "PELIAPP";
int _currentIndex = 0;
//punto inicial donde se ejecuntan las app
//main el cual ejecuta runApp tiene un materialApp home
//widget StatefulWdget
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PELIAPP',
    theme: ThemeData.dark(),
    home: MyMobvieApp(),
  )
);

class MyMobvieApp extends StatefulWidget {
  @override
  _MyMobvieApp  createState() => new _MyMobvieApp ();
  }



class _MyMobvieApp extends State<MyMobvieApp> {
  Movie nowPlayingMovies;
  Movie incommigMovies;
  Movie popularMovies;
  Movie topRateMovie;
  int heroTag = 0;
  //permite llamar acciones de primero antes de que se ejecute el build
  @override
  void initState() {
    super.initState();
    _findNowPlayList();
    _fetchUpComingMovies();
    _fetchTopRateMovies();
    _fetchPopularMovies();
  }

  void  _findNowPlayList() async {
   var response = await http.get(nowPlaying);
   var decodeJSON = jsonDecode(response.body);
   setState(() {
     nowPlayingMovies =  Movie.fromJson(decodeJSON);
   });
 }

 void _fetchUpComingMovies()  async {
   var response = await http.get(upCommingURL);
   var decodeJSON = jsonDecode(response.body);
   setState(() {
     incommigMovies =  Movie.fromJson(decodeJSON);
   });
  }

  void _fetchTopRateMovies()  async {
    var response = await http.get(topRateURL);
    var decodeJSON = jsonDecode(response.body);
    setState(() {
      topRateMovie =  Movie.fromJson(decodeJSON);
    });
  }

  void _fetchPopularMovies()  async {
    var response = await http.get(popularURL);
    var decodeJSON = jsonDecode(response.body);
    setState(() {
      popularMovies =  Movie.fromJson(decodeJSON);
    });
  }


  Widget _buildCarouselSlider() => CarouselSlider(
      items: nowPlayingMovies == null ? <Widget>[Center(
          child: CircularProgressIndicator())]
          : nowPlayingMovies.results.map((f)=> viewMovieItem(f)).toList(),
    height: 240.0,
    autoPlay: true,
    viewportFraction: 0.5,
  );



  Widget viewMovieItem(Results results)  {
    heroTag  +=1;
    return Material(
      elevation: 15.0,
      child: InkWell(
        onTap: (){},
        child:  Hero(tag: heroTag, child: Image.
        network("${baseUrlImage}w342${results.posterPath}", fit: BoxFit.cover,)
        )
      ),
      );
  }


  Widget _buildMovieListItem(Results movieItem)  => Material(
    child: Container(
      width: 128.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(6.0), child: viewMovieItem(movieItem)
          ), Padding(padding: EdgeInsets.only(left: 6.0, top: 2.0)
              , child: Text(movieItem.title, style: TextStyle(
              fontSize: 8.0,
            ), overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 6.0, top: 2.0),
                  child: Text(DateFormat('yyyy')
                      .format(DateTime.parse(movieItem.releaseDate)) ,
                      style: TextStyle(fontSize: 8.0)),
          )
        ],
      ),
    ),
  );

  Widget _buildMoviesListView(Movie movie, String movieListTitle)  =>
      Container(
        height: 258.0,
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: BoxDecoration(color: Colors.black54.withOpacity(0.4))
        ,child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 7.0, bottom: 7.0),
            child: Text(movieListTitle, style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400]
            ),
            )
            ,), Flexible(child: ListView(
            scrollDirection: Axis.horizontal,
            children: movie == null ? <Widget>
            [Center(child: (CircularProgressIndicator())
              )
            ]: movie.results.map((movieItem)=> Padding(
              padding: EdgeInsets.only(left: 6.0, right: 2.0),
              child: _buildMovieListItem(movieItem)),
            ).toList(),
          )
          )
        ],
      ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0, title: Text
        (PELITITULO, style: TextStyle(
          color: Colors.white, fontSize: 14.0,
          fontWeight: FontWeight.bold),),
        centerTitle: true ,
        leading: IconButton
          (icon: Icon(
            Icons.menu), onPressed: (){ }), actions: <Widget>[
        IconButton(icon: Icon(Icons.search) ,onPressed: (){})
      ],),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext  context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(title: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(NOWPLAYLIST, style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
                ),
              ),expandedHeight: 290.0, floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(children: <Widget>[
                      Container(child: Image.network(
                        "${baseUrlImage}w500/518jdIQHCZmYqIcNCaqbZuDRheV.jpg",
                        fit: BoxFit.cover,
                        width: 1000.0,
                        colorBlendMode: BlendMode.dstATop,
                        color: Colors.black54.withOpacity(0.5),
                      ),
                      ),
                      Padding(padding: const EdgeInsets.only(top: 35),
                        child:  _buildCarouselSlider(),
                      )
                    ],
                    ),
                  )
              )
            ];}, body: Center(
          child: ListView(children: <Widget>[
            _buildMoviesListView(incommigMovies, "PROXIMAMENTE"),
            _buildMoviesListView(popularMovies, "POPULAR"),
            _buildMoviesListView(topRateMovie, "LOS MAS VALORADOS")
          ],)
      )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.lightGreen,
        onTap: (int index) {
          setState(() {

            _currentIndex = index;


          });

        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.local_movies),
              title: Text("PELICULAS")),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag_faces),
            title: Text("TIQUETES"),
          ), 
          BottomNavigationBarItem(icon: Icon(Icons.person),
          title: Text("Cuenta")
          )
        ],

      ),

    );
  }
}

