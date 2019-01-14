import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie.model.dart';

const baseUrl = "https://api.themoviedb.org/3/movie/";
const baseUrlImage = "https://image.tmdb.org/t/p/w500/";
const apikey = "4f843d6d803eef3464b55ea6e71e1890";
const nowPlaying = "${baseUrl}now_playing?api_key=$apikey";

class Services {
     Future<Movie> findNowPlayList() async {
    var response  = await http.get(nowPlaying);
    var decodeJSON = jsonDecode(response.body);
    return Movie.fromJson(decodeJSON);
  }


}