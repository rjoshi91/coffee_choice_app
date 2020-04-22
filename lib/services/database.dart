import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference coffeeCollection = Firestore.instance.collection("coffees");

  Future updateUserData(String name, String code, String mobile, String seatNumber) async {
    return await coffeeCollection.document(uid).setData({
      'name': name,
      'code': code,
      'mobile': mobile,
      'seatNumber': seatNumber,
    });
  }

  // get brews stream
  Stream<QuerySnapshot> get coffees{
    return coffeeCollection.snapshots();
  }

}