import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guru4cars/models/brew.dart';
import 'package:guru4cars/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    //use doc instead of document & set instead of setData
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((d) {
        return Brew(
          name: d.get("name") ?? "",
          sugars: d.get("sugars") ?? "0",
          strength: d.get("strength") ?? 0,
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  UserModel _userModelFromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserModel> get userData {
    return brewCollection.doc(uid).snapshots().map(_userModelFromSnapshot);
  }
}
