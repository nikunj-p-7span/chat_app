import 'dart:async';

import 'package:chat_app/app/core/data/UserDetail.dart';
import 'package:chat_app/boxes.dart';
import 'package:chat_app/module/detail/bloc/messages_event.dart';
import 'package:chat_app/module/detail/bloc/messages_state.dart';
import 'package:chat_app/module/detail/model/messages_model.dart';
import 'package:chat_app/module/detail/repository/messages_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessagesRepository messagesRepository;
  MessagesBloc({required this.messagesRepository}) : super(const MessagesState.initial()) {
    on<AddMessages>(_addMessages);
    on<GetMessagesList>(_getMessages);
  }

  FutureOr<void> _addMessages(AddMessages event, Emitter<MessagesState> emit) async {
    UserDetail userDetail = boxUserDetail.get('UserDetail1');
    if (event.convoId.isEmpty) {
      emit(const MessagesState.error(message: 'Conversation id not found'));
    }

    if (event.content.isEmpty) {
      emit(const MessagesState.error(message: 'Content is Empty'));
    }

    if (event.idTo.isEmpty) {
      emit(const MessagesState.error(message: 'UserId of this person not Found'));
    }

    if (userDetail.uid.isEmpty) {
      emit(const MessagesState.error(message: 'UserId of current user not Found'));
    }

    try {
      emit(const MessagesState.loading());
      final String success = await messagesRepository.addChatMessages(
          content: event.content, idTo: event.idTo, timestamp: event.timestamp, convoId: event.convoId, userId: userDetail.uid);
      emit(MessagesState.loaded(message: success));
    } catch (e) {
      emit(MessagesState.error(message: e.toString()));
    }
  }

  FutureOr<void> _getMessages(GetMessagesList event, Emitter<MessagesState> emit) async {
    if (event.convoId.isEmpty) {
      emit(const MessagesState.error(message: 'Conversation id not found'));
    }

    try {
      emit(const MessagesState.loading());
      final List<MessagesModel> messagesList = await messagesRepository.getChatMessages(convId: event.convoId);
      emit(MessagesState.loaded(messagesList: messagesList));
    } catch (e) {
      emit(MessagesState.error(message: e.toString()));
    }
  }
}
