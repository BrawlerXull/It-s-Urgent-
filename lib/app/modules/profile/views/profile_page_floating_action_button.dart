import 'package:flutter/material.dart';

class ProfilePageFloatingActionButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final void Function()? onPressedCancel;
  final void Function()? onPressedSave;
  const ProfilePageFloatingActionButton(
      {required this.onPressedSave,
      required this.onPressedCancel,
      required this.nameController,
      required this.emailController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Edit Profile'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: onPressedCancel,
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: onPressedSave,
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
      child: const Icon(Icons.edit),
    );
  }
}
