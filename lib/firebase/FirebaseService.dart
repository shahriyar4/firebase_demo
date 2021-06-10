import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_demo/models/Users.dart';

class FirebaseService {
  var refUsers = FirebaseDatabase.instance.reference().child("users_table");

  Future<void> addUser() async {
    var information = HashMap<String, dynamic>();

    information["user_name"] = "Demo";
    information["user_age"] = 43;

    refUsers.push().set(information);

  }

  Future<void> deleteUser() async {
    refUsers.child("-Mbm3fUb-sMWEjJsGpLo").remove();
  }

  Future <Users?> getUsers() async {

    return allUser();

  }

  Future<void> updateUser() async {
    var updateInformation = HashMap<String, dynamic>();

    updateInformation["user_name"] = "Shahriyar";
    updateInformation["user_age"] = 18;

    refUsers.child("-Mbm3o-fZwktbypEA7R4").update(updateInformation);
  }

  Future<Users?> allUser() async {
    refUsers.onValue.listen((event) {
      var values = event.snapshot.value;

      if (values != null) {
        values.forEach((key, object) {
          var user = Users.fromJson(object);

          print("******************");
          print("kişi key : $key");
          print("kişi ad : ${user.user_name}");
          print("kişi yaş : ${user.user_age}");
        });
      }
    });
  }
}
