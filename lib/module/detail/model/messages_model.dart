import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessagesModel extends Equatable {
  MessagesModel({required this.content, required this.idFrom, required this.idTo, required this.timeStamp});

  String? content;
  String? idFrom;
  String? idTo;
  Timestamp? timeStamp;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['content'] = content;
    data['idFrom'] = idFrom;
    data['idTo'] = idTo;
    data['timeStamp'] = timeStamp;
    return data;
  }

  MessagesModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    idFrom = json['idFrom'];
    idTo = json['idTo'];
    timeStamp = json['timeStamp'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [content, idFrom, idTo, timeStamp];
}
