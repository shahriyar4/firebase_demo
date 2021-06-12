import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

class FireBaseService {
  var refFilms = FirebaseDatabase.instance.reference().child("films_table");

  var refCategory =
      FirebaseDatabase.instance.reference().child("category_table");

  Future<void> addFilm() async {
    var info = HashMap<String, dynamic>();

    info["film_name"] = "Django";

    refFilms.push().set(info);
  }

  Future<void> addCategory() async {
    var info = HashMap<String, dynamic>();

    info["category_name"] = "Dram";
    info["category_id"] = "";

    refCategory.push().set(info);
  }

  Future<void> updateFilms() async {
    var updateInformation = HashMap<String, dynamic>();

    updateInformation["films_id"] = "";

    refFilms.child("-Mc0QPZ28mzkS2JwV0cn").update(updateInformation);
  }

  Future<void> updateCategory() async {
    var updateInformation = HashMap<String, dynamic>();

    updateInformation["category_id"] = "";

    refCategory.child("-Mc0R7lHDnrssGK0yX1m").update(updateInformation);
  }
}
