import 'package:firebase_demo/models/Films.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  Films? film;

  DetailsPage({required this.film});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.film!.film_name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 27, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/images/${widget.film!.film_photo}"),
            Text(
              widget.film!.film_year.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
            Text(
              widget.film!.director.director_name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
