import 'package:firebase_database/firebase_database.dart';

treeHeight(uid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid');
  final snapshot = await ref.get();
  if (snapshot.exists) {
    var data = Map<String, dynamic>.from(snapshot.value as dynamic);
    return data['treeScore'] != null ? data['treeScore'] : 0;
  }
}
