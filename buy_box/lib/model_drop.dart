import 'import.dart';

class Drop {
  final DocumentReference reference;
  static final String _collectionName = 'drops';

  double amount;
  bool active;
  String uid, userId, goalId;
  Timestamp createdAt;

  //Drop({double amount, Timestamp createdAt});

  Drop.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['uid'] != null),
        assert(map['active'] != null),
        assert(map['userId'] != null),
        uid = map['uid'],
        active = map['active'],
        userId = map['userId'],
        goalId = map['goalId'],
        amount = map['amount'],
        createdAt = map['createdAt'];

  Drop.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  static CollectionReference collection() {
    return Firestore.instance.collection(_collectionName);
  }

  static Future<Drop> getWithId(String uid) async {
    var document = await collection().document(uid).get();
    if (document.data == null) {
      print("No Drop");
      return null;
    } else {
      Drop drop = Drop.fromSnapshot(document);
      return drop;
    }
  }

  static Future<Drop> createOrUpdate({double amount, String goalId}) async {
    try {
      final uid = Uuid().v4();
      await Firestore.instance
          .collection(_collectionName)
          .document(uid)
          .setData({
        'uid': uid,
        'userId': User.authUser.uid,
        'goalId': goalId,
        'amount': amount,
        'active': true,
        'createdAt': DateTime.now(),
      });
      return await Drop.getWithId(uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
