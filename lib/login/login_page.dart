import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../intro/intro_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isError = false;
  bool _isSaveLoginChecked = true;
  bool _isPasswordVisible = false;

  // Tambahkan metode login API
  Future<void> _login() async {
    final url = Uri.parse("http://192.168.1.56:8000/api/login");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": _idController.text,
          "password": _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final username = data['username'];

        // Save token to Flutter's local storage (shared_preferences)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('Token', token);
        await prefs.setString('Username', username);
        // Lanjutkan ke halaman berikutnya jika login berhasil
        setState(() {
          _isError = false;
        });
        Navigator.pushReplacementNamed(context, '/intro');
        print("Token: $token");
      } else {
        setState(() {
          _isError = true;
        });
        print("Login gagal: ${response.body}");
      }
    } catch (e) {
      setState(() {
        _isError = true;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Masukkan ID dan kata sandi Anda untuk melanjutkan.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple),
                ),
                errorText: _isError ? 'ID atau Kata Sandi salah' : null,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible, // Toggle password visibility
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.purple),
                ),
                errorText: _isError ? 'ID atau Kata Sandi salah' : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isSaveLoginChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isSaveLoginChecked = value!;
                    });
                  },
                ),
                Text('Simpan aktivitas login'),
              ],
            ),
            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _login, // Ubah panggilan onPressed ke _login
                  child: Text(
                    'Masuk',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
