import 'package:chat_app/app/core/utils/app_utils.dart';
import 'package:chat_app/module/chat/model/user_model.dart';
import 'package:equatable/equatable.dart';

class ChatListingState extends Equatable {
  final String message;
  final ApiStatus status;
  final List<UserModel> userList;

  const ChatListingState._({
    this.message = '',
    this.status = ApiStatus.initial,
    this.userList = const <UserModel>[],
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message, status, userList];

  const ChatListingState.initial() : this._(status: ApiStatus.initial);

  const ChatListingState.loading() : this._(status: ApiStatus.loading);

  const ChatListingState.loaded({required List<UserModel> userList}) : this._(status: ApiStatus.loaded, userList: userList);

  const ChatListingState.error({required String message}) : this._(status: ApiStatus.error, message: message);
}
