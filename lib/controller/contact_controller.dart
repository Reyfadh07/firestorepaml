import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestorepaml/contact_model.dart';

class ContactController {
  final contactcollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactcollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future<void> updateContact(ContactModel ctmodel) async {
    final ContactModel contactModel = ContactModel(
        id: ctmodel.id,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await contactcollection.doc(ctmodel.id).update(contactModel.toMap());
  }

  Future<void> removeContact(String id) async {
    await contactcollection.doc(id).delete();
  }

  Future getContact() async {
    final contact = await contactcollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }
}
