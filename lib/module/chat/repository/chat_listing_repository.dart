import 'package:chat_app/app/core/data/UserDetail.dart';
import 'package:chat_app/boxes.dart';
import 'package:chat_app/module/chat/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChatListingRepository {
  UserDetail userDetail = boxUserDetail.get('UserDetail1');

  final fireBaseFireStore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUserList() async {
    debugPrint('_auth doc ${fireBaseFireStore.collection('users').doc('userId')}');
    var collection = fireBaseFireStore.collection('users').where('id', isNotEqualTo: userDetail.uid);

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
