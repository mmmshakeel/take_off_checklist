import 'package:flutter/material.dart';
import 'package:take_off_checklist/models/checklist.dart';

class ChecklistScreen extends StatefulWidget {
  final Checklist checklist;

  ChecklistScreen({required this.checklist});

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  void _toggleCheckItem(int index) {
    setState(() {
      widget.checklist.items[index].isChecked =
          !widget.checklist.items[index].isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool allChecked = widget.checklist.items.every((item) => item.isChecked);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.checklist.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.checklist.items.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(widget.checklist.items[index].description),
                  value: widget.checklist.items[index].isChecked,
                  onChanged: (value) {
                    _toggleCheckItem(index);
                  },
                );
              },
            ),
          ),
          if (allChecked)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('All Checked!',
                  style: TextStyle(color: Colors.green, fontSize: 18)),
            ),
        ],
      ),
    );
  }
}
