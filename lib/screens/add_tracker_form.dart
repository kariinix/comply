import 'package:flutter/material.dart';

class AddTrackerForm extends StatefulWidget {
  const AddTrackerForm({super.key});

  @override
  State<AddTrackerForm> createState() => _AddTrackerFormState();
}

class _AddTrackerFormState extends State<AddTrackerForm> {
  String? selectedColor;
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  final List<Map<String, dynamic>> colorOptions = [
    {'name': 'Green', 'color': const Color(0xFFA2B593)},
    {'name': 'Yellow', 'color': const Color(0xFFECCFB3)},
    {'name': 'Pink', 'color': const Color(0xFFD19A90)},
    {'name': 'Brown', 'color': const Color(0xFFD1B090)},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F1E2),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter a habit name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color(0xFF2D2319),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _habitNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF2D2319),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Color(0xFF2D2319),
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter days',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Color(0xFF2D2319),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextField(
                        controller: _daysController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFF2D2319),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Color(0xFF2D2319),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '              Select color',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xFF2D2319),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      children: colorOptions.map((item) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = item['name'];
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: selectedColor == item['name']
                                    ? const Color(0xFF2D2319)
                                    : Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            child: Text(
                              item['name'],
                              style: const TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2319),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                final int? days = int.tryParse(_daysController.text);
                if (selectedColor != null && days != null && days > 0) {

                  Navigator.pop(context, {
                    'habit_name': _habitNameController.text,
                    'days': days,
                    'color': colorOptions.firstWhere((item) => item['name'] == selectedColor)['color'].value.toString(),
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD1B090),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: const BorderSide(
                    color: Color(0xFF2D2319),
                    width: 1.5,
                  ),
                ),
              ),
              child: const Text(
                'Add habit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2319),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
