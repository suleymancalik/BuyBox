import 'import.dart';

class Goal {
  final DocumentReference reference;
  static final String _collectionName = 'goals';

  static Goal currentGoal;

  bool active, completed;
  String uid, userId;
  double totalAmount, reachedAmount;
  Timestamp createdAt, updatedAt;

  Goal.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['uid'] != null),
        assert(map['active'] != null),
        assert(map['userId'] != null),
        uid = map['uid'],
        active = map['active'],
        completed = map['completed'],
        userId = map['userId'],
        totalAmount = map['totalAmount'],
        reachedAmount = map['reachedAmount'],
        createdAt = map['createdAt'],
        updatedAt = map['updatedAt'];

  Goal.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  static CollectionReference collection() {
    return Firestore.instance.collection(_collectionName);
  }

  static DocumentReference document(String uid) {
    return collection().document(uid);
  }

  static Future<Goal> getWithId(String uid) async {
    var document = await collection().document(uid).get();
    if (document.data == null) {
      print("No Goal");
      return null;
    } else {
      Goal goal = Goal.fromSnapshot(document);
      return goal;
    }
  }

  static Future<QuerySnapshot> getWithUserId(String userId) async {
    Query query = collection()
        .where('userId', isEqualTo: userId)
        .where('active', isEqualTo: true)
        .where('completed', isEqualTo: false);
    return query.snapshots().first;
  }

  static Future<Goal> createOrUpdate({double amount}) async {
    try {
      final uid = Uuid().v4();
      await document(uid).setData({
        'uid': uid,
        'userId': User.authUser.uid,
        'totalAmount': amount,
        'reachedAmount': 0.0,
        'active': true,
        'completed': false,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now()
      });
      return await Goal.getWithId(uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Goal> addNewDrop(double amount) async {
    Drop drop = await Drop.createOrUpdate(amount: amount, goalId: this.uid);
    if (drop != null) {
      document(uid).updateData({
        'reachedAmount': reachedAmount + amount,
        'updatedAt': DateTime.now()
      });
      return await Goal.getWithId(uid);
    } else {
      return null;
    }
    //Drop drop = Drop(amount: amount, createdAt: Timestamp.fromDate(DateTime.now()));
  }
}
