import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/models/Categories.dart';
import 'package:firebase_demo/models/Films.dart';
import 'package:firebase_demo/screens/DetailsPage.dart';
import 'package:flutter/material.dart';

class FilmsPage extends StatefulWidget {
  Categories? category;

  FilmsPage({required this.category});

  @override
  _FilmsPageState createState() => _FilmsPageState();
}

class _FilmsPageState extends State<FilmsPage> {
  var refFilms = FirebaseDatabase.instance.reference().child("films_table");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Films : ${widget.category?.category_name}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<Event>(
        stream: refFilms
            .orderByChild("category_name")
            .equalTo(widget.category?.category_name)
            .onValue,
        builder: (context, event) {
          if (event.hasData) {
            var filmList = <Films>[];
            var value = event.data!.snapshot.value;

            if (value != null) {
              value.forEach((key, object) {
                var valueFilms = Films.json(key, object);

                filmList.add(valueFilms);
              });
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: filmList.length,
              itemBuilder: (context, index) {
                var film = filmList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          film: film,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              "http://kasimadalan.pe.hu/filmler/resimler/${film.film_photo}"),
                        ),
                        Text(
                          "${film.film_name}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
