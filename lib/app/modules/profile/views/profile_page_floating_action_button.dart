import 'package:flutter/material.dart';

class ProfilePageFloatingActionButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final int urgencyStatus;
  final void Function()? onPressedCancel;
  final void Function()? onPressedSave;
  final void Function(int?)? onDropDownChanged;
  const ProfilePageFloatingActionButton(
      {required this.onPressedSave,
      required this.onPressedCancel,
      required this.nameController,
      required this.emailController,
      required this.onDropDownChanged,
      required this.urgencyStatus,
      super.key});

  @override
  State<ProfilePageFloatingActionButton> createState() =>
      _ProfilePageFloatingActionButtonState();
}

class _ProfilePageFloatingActionButtonState
    extends State<ProfilePageFloatingActionButton> {
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
                  controller: widget.nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const Text("Urgency Status"),
                const SizedBox(height: 5),
                DropdownButton<int>(
                  value: widget.urgencyStatus,
                  onChanged: widget.onDropDownChanged,
                  items: [1, 2, 3].map((value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: widget.onPressedCancel,
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: widget.onPressedSave,
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
