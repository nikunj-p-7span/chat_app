import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/app/core/data/UserDetail.dart';
import 'package:chat_app/app/core/utils/app_utils.dart';
import 'package:chat_app/boxes.dart';
import 'package:chat_app/module/authentication/bloc/authentication_bloc.dart';
import 'package:chat_app/module/authentication/repository/authentication_repository.dart';
import 'package:chat_app/module/chat/bloc/chat_listing_bloc.dart';
import 'package:chat_app/module/chat/bloc/chat_listing_event.dart';
import 'package:chat_app/module/chat/bloc/chat_listing_state.dart';
import 'package:chat_app/module/chat/repository/chat_listing_repository.dart';
import 'package:chat_app/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChatScreen extends StatefulWidget implements AutoRouteWrapper {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (context) => ChatListingRepository(),
        ),
        BlocProvider(
          create: (context) => ChatListingBloc(chatListingRepository: context.read<ChatListingRepository>()),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository: context.read<AuthenticationRepository>(),
          ),
        ),
      ],
      child: this,
    );
  }
}

class _ChatScreenState extends State<ChatScreen> {
  final chatListingRepository = ChatListingRepository();

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        actions: [
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                context.router.replaceAll([const LoginRoute()]);
              }
            },
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(const LogoutEvent());
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.lightBlueAccent,
        title: const Text(
          'Conversation',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 1,
        scrolledUnderElevation: 1,
        // backgroundColor: backgroundColor ?? context.colorScheme.background,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ChatListingBloc, ChatListingState>(
          builder: (context, state) {
            switch (state.status) {
              case ApiStatus.initial:
              case ApiStatus.loading:
              case ApiStatus.loaded:
                return ListView.builder(
                  itemCount: state.userList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.pushRoute(MessagesRoute(
                          convoId: getChatId(peerId: state.userList[index].id ?? ''),
                          idTo: state.userList[index].id,
                          isOnline: 'online',
                          name: state.userList[index].displayName,
                          imageUrl: state.userList[index].photoUrl,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: ListTile(
                            title: Text(state.userList[index].displayName ?? 'Abc'),
                            tileColor: Colors.grey.shade100,

                            ///ADD last message
                            subtitle: const Text('Last Message'),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: CachedNetworkImage(
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                imageUrl: state.userList[index].photoUrl ??
                                    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D',
                              ),
                            )),
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
    );
  }

  void getUsers() {
    context.read<ChatListingBloc>().add(const GetChatListEvent());
  }

  String getChatId({required String peerId}) {
    UserDetail userDetail = boxUserDetail.get('UserDetail1');
    if (userDetail.uid.hashCode <= peerId.hashCode) {
      return '${userDetail.uid}_$peerId';
    } else {
      return '${peerId}_${userDetail.uid}';
    }
  }
}
