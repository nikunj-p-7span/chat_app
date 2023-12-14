import 'dart:async';

import 'package:chat_app/module/chat/bloc/chat_listing_event.dart';
import 'package:chat_app/module/chat/bloc/chat_listing_state.dart';
import 'package:chat_app/module/chat/model/user_model.dart';
import 'package:chat_app/module/chat/repository/chat_listing_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListingBloc extends Bloc<ChatListingEvent, ChatListingState> {
  final ChatListingRepository chatListingRepository;

  ChatListingBloc({required this.chatListingRepository}) : super(const ChatListingState.initial()) {
    on<ChatListingEvent>(_chatListing);
  }

  FutureOr<void> _chatListing(
    ChatListingEvent event,
    Emitter<ChatListingState> emit,
  ) async {
    try {
      emit(const ChatListingState.loading());
      final List<UserModel> userList = await chatListingRepository.getUserList();
      emit(ChatListingState.loaded(userList: userList));
    } catch (e) {
      emit(ChatListingState.error(message: e.toString()));
    }
  }
}
