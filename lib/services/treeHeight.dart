import 'package:firebase_database/firebase_database.dart';

treeHeight(uid) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid');
  ref.onValue.listen((event) {
    var data = Map<String, dynamic>.from(event.snapshot.value as dynamic);
    print(data);
    return data['treeScore'] != null ? data['treeScore'] : 0;
  });
}
