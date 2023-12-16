import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/app/core/data/UserDetail.dart';
import 'package:chat_app/app/core/utils/app_utils.dart';
import 'package:chat_app/app/helpers/mixins/pagination_mixin.dart';
import 'package:chat_app/boxes.dart';
import 'package:chat_app/module/chat/bloc/chat_listing_bloc.dart';
import 'package:chat_app/module/chat/repository/chat_listing_repository.dart';
import 'package:chat_app/module/detail/bloc/messages_bloc.dart';
import 'package:chat_app/module/detail/bloc/messages_event.dart';
import 'package:chat_app/module/detail/bloc/messages_state.dart';
import 'package:chat_app/module/detail/model/messages_model.dart';
import 'package:chat_app/module/detail/repository/messages_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MessagesScreen extends StatefulWidget implements AutoRouteWrapper {
  const MessagesScreen({
    super.key,
    required this.name,
    required this.isOnline,
    required this.imageUrl,
    required this.idTo,
    required this.convoId,
  });

  final String? name;
  final String? isOnline;
  final String? imageUrl;
  final String? idTo;
  final String? convoId;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      RepositoryProvider(
        create: (context) => ChatListingRepository(),
      ),
      RepositoryProvider(
        create: (context) => MessagesRepository(),
      ),
      BlocProvider(
        create: (context) => ChatListingBloc(chatListingRepository: context.read<ChatListingRepository>()),
      ),
      BlocProvider(
        create: (context) => MessagesBloc(messagesRepository: context.read<MessagesRepository>()),
      ),
    ], child: this);
  }
}

class _MessagesScreenState extends State<MessagesScreen> with PaginationService {
  TextEditingController messageWritten = TextEditingController();
  List<MessagesModel> messages = [];
  UserDetail userDetail = boxUserDetail.get('UserDetail1');

  @override
  void initState() {
    getMessageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        leading: BackButton(
          onPressed: () {
            context.popRoute();
          },
        ),
        shadowColor: Colors.lightBlue,
        clipBehavior: Clip.none,
        titleSpacing: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(
              20,
            ),
            bottomLeft: Radius.circular(
              20,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                20,
              ),
              bottomLeft: Radius.circular(
                20,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: CachedNetworkImage(
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                imageUrl: widget.imageUrl ?? '',
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  widget.isOnline ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          )
        ],
        elevation: 1,
        scrolledUnderElevation: 1,
        // backgroundColor: backgroundColor ?? context.colorScheme.background,
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                switch (state.status) {
                  case ApiStatus.initial:
                  case ApiStatus.loading:
                  case ApiStatus.loaded:
                    return ListView.builder(
                      dragStartBehavior: DragStartBehavior.start,
                      controller: scrollController,
                      itemCount: state.messagesList.length,
                      shrinkWrap: false,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: state.messagesList[index].idFrom == userDetail.uid
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  ///TODO: message per border ui
                                  borderRadius: BorderRadius.only(
                                    bottomRight: state.messagesList[index].idFrom == userDetail.uid
                                        ? const Radius.circular(0)
                                        : const Radius.circular(20),
                                    bottomLeft: state.messagesList[index].idFrom == userDetail.uid
                                        ? const Radius.circular(20)
                                        : const Radius.circular(0),
                                    topLeft: const Radius.circular(20),
                                    topRight: const Radius.circular(20),
                                  ),
                                  color: Colors.lightBlueAccent,
                                ),
                                child: Text(
                                  state.messagesList[index].content ?? 'fool',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  case ApiStatus.error:
                    return Center(
                        child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 5,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      hoverColor: Colors.white,
                      suffixIcon: IconButton(
                          onPressed: () {
                            context.read<MessagesBloc>().add(AddMessages(
                                  content: messageWritten.text,
                                  idTo: widget.idTo ?? '',
                                  timestamp: Timestamp.now(),
                                  convoId: widget.convoId ?? '',
                                ));
                            getMessageList();
                            messageWritten.clear();
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.lightBlueAccent,
                          )),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    controller: messageWritten,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void getMessageList() {
    context.read<MessagesBloc>().add(GetMessagesList(convoId: widget.convoId ?? ''));
  }

  @override
  void onEndScroll() {}
}
