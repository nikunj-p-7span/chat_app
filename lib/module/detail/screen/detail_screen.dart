import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/app/helpers/mixins/pagination_mixin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.name,
    required this.isOnline,
    required this.imageUrl,
  });
  final String? name;
  final String? isOnline;
  final String? imageUrl;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with PaginationService {
  TextEditingController messageWritten = TextEditingController();
  List<String> messages = [];

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
                const Text(
                  'Chat Details',
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
          StatefulBuilder(
            builder: (context, setState) {
              return Expanded(
                child: ListView.builder(
                  dragStartBehavior: DragStartBehavior.start,
                  controller: scrollController,
                  itemCount: messages.length,
                  shrinkWrap: false,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              ///TODO: message per border ui
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: Colors.lightBlueAccent,
                            ),
                            child: Text(
                              messages[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
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
                            setState(() {
                              messages.add(messageWritten.text);
                            });
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

  @override
  void onEndScroll() {}
}
