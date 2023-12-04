// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/select_contact/controller/select_contact_controller.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = "/select-contact";
  const SelectContactsScreen({super.key});
void selectContact(WidgetRef ref, Contact selectedContact, BuildContext context){
  ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select contact"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
          data: (ContactsList) => ListView.builder(
                itemCount: ContactsList.length,
                itemBuilder: (context, index) {
                  final contact = ContactsList[index];
                  return InkWell(
                    onTap: () => selectContact(ref, contact, context),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(contact.displayName,style: const TextStyle(fontSize: 18),),
                        leading: contact.photo==null? null : CircleAvatar(
                          backgroundImage: MemoryImage(contact.photo!),
                          radius: 30,
                        ),
                      ),
                    ),
                  );
                },
              ),
          error: (err, trace) => ErrorScreen(error: err.toString()),
          loading: () => const Loader()),
    );
  }
}
