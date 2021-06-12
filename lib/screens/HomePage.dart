import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/firebase/FirebaseService.dart';
import 'package:firebase_demo/models/Categories.dart';
import 'package:firebase_demo/models/Users.dart';
import 'package:firebase_demo/screens/FilmsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseService = FireBaseService();

  late Future<Users?> futureUsers;

  @override
  void initState() {
    super.initState();
    //firebaseService.addFilm();
    //firebaseService.addCategory();
    //firebaseService.updateFilms();
    // firebaseService.updateCategory();
  }

  var refCategory =
      FirebaseDatabase.instance.reference().child("category_table");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Films",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<Event>(
        stream: refCategory.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var categoryList = <Categories>[];
            var value = event.data!.snapshot.value;

            if (value != null) {
              value.forEach((key, object) {
                var valueCategory = Categories.fromJson(key, object);

                categoryList.add(valueCategory);
              });
            }

            return ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                var category = categoryList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilmsPage(category: category),
                      ),
                    );
                  },
                  child: Card(
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${category.category_name}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          )
                        ],
                      ),
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
