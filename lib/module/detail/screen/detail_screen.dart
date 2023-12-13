import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController messageWritten = TextEditingController();
  List<String> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.lightBlueAccent,
                              ),
                              child: Text(
                                messages[index],
                                style: const TextStyle(color: Colors.white),
                              )),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 75,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    )),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        controller: messageWritten,
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            messages.add(messageWritten.text);
                          });
                          messageWritten.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.lightBlueAccent,
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
