import 'package:firebase_demo/firebase/FirebaseService.dart';
import 'package:firebase_demo/models/Categories.dart';
import 'package:firebase_demo/models/Users.dart';
import 'package:firebase_demo/screens/DetailsPage.dart';
import 'package:firebase_demo/screens/FilmsPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseService = FirebaseService();

  late Future<Users?> futureUsers;

  @override
  void initState() {
    super.initState();
    //firebaseService.allUser();
    // firebaseService.addUser();
    futureUsers = firebaseService.getUsers();
  }

  Future<List<Categories>> allCategories() async {
    var categoryList = <Categories>[];

    var k1 = Categories(1, "Comedy");
    var k2 = Categories(2, "Science Fiction");

    categoryList.add(k1);
    categoryList.add(k2);

    return categoryList;
  }

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
      body: FutureBuilder<List<Categories>>(
        future: allCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var categortList = snapshot.data;

            return ListView.builder(
              itemCount: categortList?.length,
              itemBuilder: (context, index) {
                var category = categortList?[index];

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
                        children: [Text("${category?.categoriy_name}",style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),)],
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
