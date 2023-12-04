// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/select_contact/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final SelectContactRepository = ref.watch(SelectContactRepositoryProvider);
  return SelectContactRepository.getContacts();
});
final selectContactControllerProvider = Provider((ref) {
  final SelectContactRepository = ref.watch(SelectContactRepositoryProvider);
  return selectContactController(
      ref: ref, selectContactRepository: SelectContactRepository);
});

class selectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  selectContactController(
      {required this.ref, required this.selectContactRepository});
  void selectContact(Contact selectedContact, BuildContext context) {
    selectContactRepository.selectContact(selectedContact, context);
  }
}
