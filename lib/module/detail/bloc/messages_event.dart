import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

sealed class MessagesEvent extends Equatable {}

class GetMessagesList extends MessagesEvent {
  final String convoId;

  GetMessagesList({required this.convoId});

  @override
  List<Object?> get props => [convoId];
}

class AddMessages extends MessagesEvent {
  final String content;
  final String idTo;
  final Timestamp timestamp;
  final String convoId;

  AddMessages({required this.content, required this.idTo, required this.timestamp, required this.convoId});

  @override
  List<Object?> get props => [content, idTo, timestamp, convoId];
}
