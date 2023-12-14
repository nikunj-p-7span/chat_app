import 'package:equatable/equatable.dart';

sealed class ChatListingEvent extends Equatable {
  const ChatListingEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetChatListEvent extends ChatListingEvent {
  const GetChatListEvent();
}
