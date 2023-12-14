import 'package:chat_app/module/chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ChatListingRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fireBaseFireStore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUserList() async {
    debugPrint('_auth ${_auth.currentUser?.uid}');
    debugPrint('_auth doc ${fireBaseFireStore.collection('users').doc('userId')}');
    var collection = fireBaseFireStore.collection('users').where('id', isNotEqualTo: _auth.currentUser?.uid ?? '');

    QuerySnapshot querySnapshot = await collection.get();

    List<UserModel> userList = [];

    userList.addAll(querySnapshot.docs.map((doc) {
      debugPrint('doc data ${doc.data()}');

      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }));
    debugPrint('userList $userList');

    return userList;
  }
}
