import 'package:movie_app_vmo/database/database_app.dart';

class MovieLiked {
  String? ownerName;
  int? idMovie;
  MovieLiked({this.ownerName,this.idMovie});
  Map<String,dynamic> toMap(){
    return {
      DatabaseMovie.OWNER: ownerName,
      DatabaseMovie.ID_VIDEO:idMovie,
    };
  }
}