import 'package:chat_app/module/detail/model/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesRepository {
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<String> addChatMessages({
    required String content,
    required String idTo,
    required Timestamp timestamp,
    required String convoId,
    required String userId,
  }) async {
    firebaseFireStore.collection('chat').doc(convoId).collection('messages').doc().set({
      'content': content,
      'idFrom': userId,
      'idTo': idTo,
      'timeStamp': timestamp,
    });
    return 'Added Successfully';
  }

  Future<List<MessagesModel>> getChatMessages({required String convId}) async {
    var collection =
        firebaseFireStore.collection('chat').doc(convId).collection('messages').orderBy("timeStamp", descending: false);
    QuerySnapshot querySnapshot = await collection.get();

    List<MessagesModel> messageList = [];

    messageList.addAll(querySnapshot.docs.map((doc) => MessagesModel.fromJson(doc.data() as Map<String, dynamic>)));

    return messageList;
  }
}
