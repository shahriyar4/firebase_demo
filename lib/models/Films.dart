import 'package:firebase_demo/models/Categories.dart';
import 'package:firebase_demo/models/Directors.dart';

class Films {
  String film_id;
  String film_name;
  int film_year;
  String film_photo;
  String category_name;
  String director_name;

  Films(this.film_id, this.film_name, this.film_year, this.film_photo,
      this.category_name, this.director_name);

  factory Films.json(String key, Map<dynamic, dynamic> json) {
    return Films(
        key,
        json["film_name"] as String,
        json["film_year"] as int,
        json["film_photo"] as String,
        json["category_name"] as String,
        json["director_name"] as String);
  }
}
