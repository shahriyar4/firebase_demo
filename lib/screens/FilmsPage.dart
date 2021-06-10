import 'package:firebase_demo/models/Categories.dart';
import 'package:firebase_demo/models/Directors.dart';
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
  Future<List<Films>> allFilms(dynamic category_id) async {
    var filmList = <Films>[];

    var k1 = Categories(1, "Comedy");
    var y1 = Directors(1, "Quentin Tarantino");

    var f1 = Films(1, "Anadoluda", 2008, "anadoluda.png", k1, y1);
    var f2 = Films(2, "Django", 2009, "django.png", k1, y1);
    var f3 = Films(3, "Inception", 2010, "inception.png", k1, y1);

    filmList.add(f1);
    filmList.add(f2);
    filmList.add(f3);
    return filmList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Films : ${widget.category?.categoriy_name}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<Films>>(
        future: allFilms(widget.category?.categoriy_id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var filmList = snapshot.data;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: filmList?.length,
              itemBuilder: (context, index) {
                var film = filmList?[index];

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
                          child:
                              Image.asset("assets/images/${film!.film_photo}"),
                        ),
                        Text(
                          "${film!.film_name}",
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
