import 'package:flutter/material.dart';
import '../models/win_model.dart';

class AddWinDialog extends StatefulWidget {
  final void Function(Win) onWinAdded;

  const AddWinDialog({
    Key? key,
    required this.onWinAdded,
  }) : super(key: key);

  @override
  State<AddWinDialog> createState() => _AddWinDialogState();
}

class _AddWinDialogState extends State<AddWinDialog> {
  final TextEditingController _winController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildNameField(),
              const SizedBox(height: 12),
              _buildCompanyField(),
              const SizedBox(height: 12),
              _buildWinField(),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Share Your Win! 🎉',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF667eea),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Your Name',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget _buildCompanyField() {
    return TextFormField(
      controller: _companyController,
      decoration: InputDecoration(
        labelText: 'Company',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.business),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your company';
        }
        return null;
      },
    );
  }

  Widget _buildWinField() {
    return TextFormField(
      controller: _winController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Your Win',
        hintText: 'What awesome thing happened? 🚀',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.celebration),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please describe your win';
        }
        return null;
      },
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _submitWin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667eea),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Share Win!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _submitWin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final newWin = Win(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      founderName: _nameController.text.trim(),
      company: _companyController.text.trim(),
      content: _winController.text.trim(),
      timestamp: DateTime.now(),
      reactions: {},
      avatar: '🚀', // Default avatar for new wins
    );

    widget.onWinAdded(newWin);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _winController.dispose();
    _nameController.dispose();
    _companyController.dispose();
    super.dispose();
  }
}