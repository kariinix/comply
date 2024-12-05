import 'package:flutter/material.dart';
import 'package:comply/database/database_helper.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'The field cannot be empty';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'The field cannot be empty';
    }
    if (value.length < 7) {
      return 'Password must be at least 7 characters';
    }
    return null;
  }

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final dbHelper = DatabaseHelper.instance;
      final db = await dbHelper.database;

      final result = await db.query(
        'users',
        where: 'name = ? AND password = ?',
        whereArgs: [_nameController.text.trim(), _passwordController.text.trim()],
      );

      if (result.isNotEmpty) {
        final userId = result.first['id'] as int;
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, '/home', arguments: userId);
        }
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong login or password!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primaryTextColor = const Color(0xFF5F6F52);
    Color buttonTextColor = const Color(0xFF2D2319);
    Color buttonBackgroundColor = const Color(0xFFD1B090);
    Color buttonBorderColor = buttonTextColor;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 90),
              SizedBox(
                height: 45,
                width: 245,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'LOGIN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                  fontSize: 36,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: buttonTextColor,
                  ),
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: buttonBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: primaryTextColor),
                  ),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: buttonTextColor,
                  ),
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: buttonBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: primaryTextColor),
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor,
                  backgroundColor: buttonBackgroundColor,
                  elevation: 4,
                  shadowColor: Colors.black54,
                  side: BorderSide(color: buttonBorderColor, width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                  fixedSize: const Size(180, 53),
                ),
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Back to login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: buttonTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
