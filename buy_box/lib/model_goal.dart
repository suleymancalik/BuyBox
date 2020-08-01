import 'import.dart';

class Goal {
  final DocumentReference reference;
  static final String _collectionName = 'goals';

  static Goal currentGoal;

  bool isActive;
  String uid, userId;

  Goal.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['uid'] != null),
      assert(map['isActive'] != null),
      assert(map['userId'] != null),
      uid = map['uid'],
      isActive = map['isActive'],
      userId = map['userId']
    ;

  Goal.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  static CollectionReference collection() {
    return Firestore.instance.collection(_collectionName);
  }


  static Future<Goal> getWithId(String uid) async {
    var document = await collection().document(uid).get();
    if (document.data == null) {
      print("No Goal");
      return null;
    }
    else {
      Goal goal = Goal.fromSnapshot(document);
      return goal;
    }
  }



  static Future<QuerySnapshot> getWithUserId(String userId) async {
    Query query = collection()
        .where('userId', isEqualTo:userId)
        .where('isActive', isEqualTo:true);
    return query.snapshots().first;
  }

}