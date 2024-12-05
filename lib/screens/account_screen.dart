import 'package:flutter/material.dart';
import 'package:comply/database/database_helper.dart';

class AccountScreen extends StatefulWidget {
  final int userId;

  const AccountScreen({super.key, required this.userId});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late String _name = "";
  late String _email = "";
  late String _password = "";
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }


  Future<void> _loadUserData() async {
    final db = await dbHelper.database;
    final user = await db.query('users', where: 'id = ?', whereArgs: [widget.userId]);

    if (user.isNotEmpty && mounted) {
      setState(() {
        _name = user.first['name'] as String;
        _email = user.first['email'] as String;
        _password = user.first['password'] as String;
      });
    }
  }

  Future<void> _deleteAccount() async {
    final db = await dbHelper.database;
    await db.delete('users', where: 'id = ?', whereArgs: [widget.userId]);

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F1E2),
      body: Column(
        children: [
          const SizedBox(height: 60.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFD1B090),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: const Color(0xFF2D2319),
                width: 1.5,
              ),
            ),
            child: Center(
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Your account in ',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF3F1E2),
                      ),
                    ),
                    TextSpan(
                      text: 'COMPLY',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2319),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 30.0,
                    color: Color(0xFF2D2319),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const Icon(
            Icons.account_circle_sharp,
            size: 80.0,
            color: Color(0xFF5F6F52),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '   Name:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color(0xFF2D2319),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(text: _name),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F1E2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2319),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2319),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '   Email:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color(0xFF2D2319),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(text: _email),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F1E2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2319),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2319),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    '   Password:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Color(0xFF2D2319),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  TextField(
                    enabled: false,
                    controller: TextEditingController(text: _password),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF3F1E2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2319),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF2D2319),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35.0),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD1B090),
                            minimumSize: const Size(160, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: Color(0xFF2D2319),
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFF2D2319),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _deleteAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD19A90),
                            minimumSize: const Size(200, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: Color(0xFF2D2319),
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Delete account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Color(0xFF2D2319),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
