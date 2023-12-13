import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/router/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        backgroundColor: Colors.lightBlueAccent,
        title: const Text('Conversation',
            style: TextStyle(
              color: Colors.white,
            )),
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
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.pushRoute(DetailRoute(
                    isOnline: 'online',
                    name: 'Name',
                    imageUrl:
                        'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D'));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 8,
                ),
                child: ListTile(
                    title: const Text('Name'),
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
                        imageUrl:
                            'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8fDA%3D',
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
