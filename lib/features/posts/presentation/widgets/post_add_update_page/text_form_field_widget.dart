import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  final String name;
  final bool multiLines;

  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.name,
      required this.multiLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? "$name Can't be Empty" : null,
        decoration: const InputDecoration(hintText: 'Title'),
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
      ),
    );
  }
}
