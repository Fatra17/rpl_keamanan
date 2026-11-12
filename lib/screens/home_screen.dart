import 'package:flutter/material.dart';
import 'post_list_screen.dart';
import '../utils/validators.dart';
import 'user_list_screen.dart';

/// Halaman utama aplikasi.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _result = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final sanitizedName = Validators.sanitize(_nameController.text);
      setState(() {
        _result = 'Valid! Nama tersanitasi: $sanitizedName';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum RPL & Keamanan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserListScreen()),
              ),
              icon: const Icon(Icons.people),
              label: const Text('Daftar Pengguna (UserRepository)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PostListScreen()),
              ),
              icon: const Icon(Icons.article),
              label: const Text('Daftar Post (PostRepository)'),
            ),
            const Divider(height: 32),
            const Text(
              'Uji Validasi & Sanitasi Dasar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) =>
                        Validators.validateText(v, fieldName: 'Nama'),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Validasi Input'),
                    ),
                  ),
                ],
              ),
            ),
            if (_result.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _result,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
