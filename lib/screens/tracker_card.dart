import 'package:flutter/material.dart';

class TrackerCard extends StatefulWidget {
  final int id;
  final String name;
  final int days;
  final Color color;
  final Function(int) onDelete;

  const TrackerCard({
    super.key,
    required this.id,
    required this.name,
    required this.days,
    required this.color,
    required this.onDelete,
  });

  @override
  TrackerCardState createState() => TrackerCardState();
}

class TrackerCardState extends State<TrackerCard> {
  late List<bool> _checkboxStates;

  @override
  void initState() {
    super.initState();
    _checkboxStates = List<bool>.filled(widget.days, false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.color,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2319),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.days} days you need do this',
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF2D2319),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_rounded, color: Color(0xFF2D2319)),
                  onPressed: () {
                    widget.onDelete(widget.id);
                  },
                ),
              ],
            ),
            const Divider(color: Color(0xFF2D2319)),
            Wrap(
              spacing: 8.0,
              children: List.generate(
                widget.days,
                    (index) => Checkbox(
                  value: _checkboxStates[index],
                      activeColor: const Color(0xFF2D2319),
                  onChanged: (bool? value) {
                    setState(() {
                      _checkboxStates[index] = value ?? false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
