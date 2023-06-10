// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firestorepaml/contact_model.dart';
import 'package:firestorepaml/view/contact.dart';
import 'package:flutter/material.dart';

import 'package:firestorepaml/controller/contact_controller.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    Key? key,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contactController = ContactController();

  String? newname;
  String? newphone;
  String? newemail;
  String? newaddress;

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onSaved: (value) {
                  newname = value;
                },
                initialValue: widget.name,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onSaved: (value) {
                  newphone = value;
                },
                initialValue: widget.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onSaved: (value) {
                  newemail = value;
                },
                initialValue: widget.email,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onSaved: (value) {
                  newaddress = value;
                },
                initialValue: widget.address,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    ContactModel cm = ContactModel(
                        id: widget.id,
                        name: newname!.toString(),
                        phone: newphone!.toString(),
                        email: newemail!.toString(),
                        address: newaddress!.toString());
                    contactController.updateContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Changed')));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ),
                    );
                  }
                  //print(cm);
                },
                child: const Text('Edit Contact'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
