import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';

import '/models/user.dart';

getUserCollection() {
  final usersCollection =
      FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );
  return usersCollection;
}

Future<MyUser> getCurrentUser(String mail) async {
  final usersCollection =
      Database.db.collection('users').doc(mail).withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  final x = await usersCollection.get();

  MyUser user = x.data()!;
  return user;
}

updateCurrentUser(MyUser user) {
  final usersCollection =
      Database.db.collection('users').doc(user.email).withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  usersCollection.update(user.toJson());
}

deleteCurrentUser(MyUser user) {
  final usersCollection =
      Database.db.collection('users').doc(user.email).withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  usersCollection.delete();
  FirebaseAuth.instance.currentUser!.delete();
}

addUser(String mail) {
  final usersCollection = Database.db.collection('users').withConverter<MyUser>(
        fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
  MyUser user = MyUser(email: mail, historique: [], lieux: []);

  usersCollection.doc(mail).set(user);
}

addUser2(String mail) async {
  final usersCollection =
      Database.db.collection('users').doc(mail).withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  final x = await usersCollection.get();
  if (x.data() == null) {
    addUser(mail);
  }
}
