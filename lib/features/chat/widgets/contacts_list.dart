import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/common/utils/colors.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp_clone/model/chat_contact.dart';

import 'package:whatsapp_clone/model/group.dart' as model;
class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<model.Group>>(
              stream: ref.watch(ChatControllerProvider).chatGroups(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var groupData = snapshot.data![index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MobileChatScreen.routeName,arguments: {
                              "name" :  groupData.name,
                              "uid":  groupData.groupId,
                              "isGroupChat" : true,
                              "profilePic" : groupData.groupPic,
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                groupData.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(groupData.lastMessage,
                                    style: const TextStyle(fontSize: 15)),
                              ),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(groupData.groupPic),
                                radius: 30,
                              ),
                              trailing: Text(
                                  DateFormat.Hm().format(groupData.timeSent),
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                            ),
                          ),
                        ),
                        const Divider(
                          color: dividerColor,
                          indent: 85,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            StreamBuilder<List<ChatContact>>(
              stream: ref.watch(ChatControllerProvider).chatContacts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var chatContactData = snapshot.data![index];
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, MobileChatScreen.routeName,arguments: {
                              "name" :  chatContactData.name,
                              "uid":  chatContactData.contactId,
                              "isGroupChat" : false,
                              "profilePic" : chatContactData.profilePicture,
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                chatContactData.name,
                                style: const TextStyle(fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: Text(chatContactData.lastMessage,
                                    style: const TextStyle(fontSize: 15)),
                              ),
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(chatContactData.profilePicture),
                                radius: 30,
                              ),
                              trailing: Text(
                                  DateFormat.Hm().format(chatContactData.timeSent),
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                            ),
                          ),
                        ),
                        const Divider(
                          color: dividerColor,
                          indent: 85,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
