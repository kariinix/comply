import 'package:flutter/material.dart';
import 'package:comply/database/database_helper.dart';
import 'add_tracker_form.dart';
import 'tracker_card.dart';

class HomeScreen extends StatefulWidget {
  final int userId;

  const HomeScreen({super.key, required this.userId});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _trackers = [];
  late int _userId;
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _userId = widget.userId;
    _loadTrackers();
  }

  Future<void> _loadTrackers() async {
    final db = await dbHelper.database;
    final data = await db.query('trackers', where: 'user_id = ?', whereArgs: [_userId]);

    setState(() {
      _trackers.clear();
      _trackers.addAll(data.map((tracker) => {
        'id': tracker['id'],
        'habit_name': tracker['name'],
        'color': tracker['color'],
        'days': tracker['days'],
        'checkbox_states': tracker['checkbox_states'],
      }));
    });
  }

  Future<void> _addTracker(Map<String, dynamic> tracker) async {
    final db = await dbHelper.database;

    final trackerId = await db.insert('trackers', {
      'user_id': _userId,
      'name': tracker['habit_name'],
      'color': tracker['color'],
      'days': tracker['days'],
      'checkbox_states': List<bool>.filled(tracker['days'], false).toString(),
    });

    setState(() {
      _trackers.add({
        'id': trackerId,
        'habit_name': tracker['habit_name'],
        'color': tracker['color'],
        'days': tracker['days'],
        'checkbox_states': List<bool>.filled(tracker['days'], false).toString(),
      });
    });
  }

  Future<void> _deleteTracker(int id) async {
    final db = await dbHelper.database;

    await db.delete('trackers', where: 'id = ?', whereArgs: [id]);

    setState(() {
      _trackers.removeWhere((tracker) => tracker['id'] == id);
    });
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
                      text: 'Welcome to  ',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF3F1E2),
                      ),
                    ),
                    TextSpan(
                      text: 'COMPLY',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2319),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'You can create a tracker with a habit\n'
                  'you want to introduce into your life',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2319),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: _trackers.isEmpty
                ? const Center(child: Text(''))
                : ListView.builder(
              itemCount: _trackers.length,
              itemBuilder: (context, index) {
                final tracker = _trackers[index];
                return TrackerCard(
                  id: tracker['id'],
                  name: tracker['habit_name'],
                  days: tracker['days'],
                  color: Color(int.parse(tracker['color'])),
                  onDelete: _deleteTracker,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/account', arguments: _userId);
              },
              backgroundColor: const Color(0xFF7C9A73),
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 100.0),
            FloatingActionButton(
              onPressed: () async {
                final newTracker = await showModalBottomSheet<Map<String, dynamic>>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  builder: (context) => const AddTrackerForm(),
                );

                if (newTracker != null) {
                  await _addTracker(newTracker);
                }
              },
              backgroundColor: const Color(0xFF7C9A73),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
