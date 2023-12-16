import 'package:chat_app/app/core/utils/app_utils.dart';
import 'package:chat_app/module/detail/model/messages_model.dart';
import 'package:equatable/equatable.dart';

class MessagesState extends Equatable {
  final String message;
  final ApiStatus status;
  final List<MessagesModel> messagesList;

  const MessagesState._({
    this.message = '',
    this.status = ApiStatus.initial,
    this.messagesList = const <MessagesModel>[],
  });

  @override
  List<Object?> get props => [message, status, messagesList];

  const MessagesState.initial() : this._(status: ApiStatus.initial);
  const MessagesState.loading() : this._(status: ApiStatus.loading);
  const MessagesState.loaded({List<MessagesModel> messagesList = const <MessagesModel>[], String message = ''})
      : this._(status: ApiStatus.loaded, messagesList: messagesList, message: message);
  const MessagesState.error({required String message}) : this._(status: ApiStatus.error, message: message);
}
