import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodLogScreen extends StatefulWidget {
  const MoodLogScreen({Key? key}) : super(key: key);

  @override
  _MoodLogScreenState createState() => _MoodLogScreenState();
}

class _MoodLogScreenState extends State<MoodLogScreen> {
  int _mood = 3; // 1-5
  final TextEditingController _noteController = TextEditingController();
  bool _saving = false;

  Future<void> _save() async {
    setState(() {
      _saving = true;
    });
    await FirebaseFirestore.instance.collection('mood_logs').add({
      'mood': _mood,
      'note': _noteController.text,
      'timestamp': Timestamp.now(),
    });
    setState(() {
      _saving = false;
    });
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Log')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('How are you feeling?'),
            Slider(
              value: _mood.toDouble(),
              onChanged: (v) => setState(() => _mood = v.round()),
              min: 1,
              max: 5,
              divisions: 4,
              label: _mood.toString(),
            ),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _saving
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _save,
                    child: const Text('Save'),
                  ),
          ],
        ),
      ),
    );
  }
}
