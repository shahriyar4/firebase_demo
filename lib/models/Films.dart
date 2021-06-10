import 'package:firebase_demo/models/Categories.dart';
import 'package:firebase_demo/models/Directors.dart';

class Films{

  int film_id;
  String film_name;
  int film_year;
  String film_photo;
  Categories category;
  Directors director;

  Films(this.film_id, this.film_name, this.film_year, this.film_photo,
      this.category, this.director);
}