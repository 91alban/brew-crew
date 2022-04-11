class UserData {
  final String? uid;

  UserData({this.uid});
}

class UserModel {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserModel({
    required this.uid,
    required this.name,
    required this.sugars,
    required this.strength,
  });
}
