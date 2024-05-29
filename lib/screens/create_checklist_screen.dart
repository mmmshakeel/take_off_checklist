import 'package:flutter/material.dart';
import 'package:take_off_checklist/models/checklist.dart';

class CreateChecklistScreen extends StatefulWidget {
  @override
  _CreateChecklistScreenState createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  final _titleController = TextEditingController();
  final List<TextEditingController> _itemControllers = [];

  void _addChecklistItem() {
    setState(() {
      _itemControllers.add(TextEditingController());
    });
  }

  void _saveChecklist() {
    String title = _titleController.text;
    List<ChecklistItem> items = _itemControllers
        .map((controller) => ChecklistItem(description: controller.text))
        .toList();

    Checklist newChecklist = Checklist(title: title, items: items);

    Navigator.pop(context, newChecklist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Checklist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Checklist Title'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _itemControllers.length,
                itemBuilder: (context, index) {
                  return TextField(
                    controller: _itemControllers[index],
                    decoration: InputDecoration(labelText: 'Item ${index + 1}'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addChecklistItem,
              child: const Text('Add Item'),
            ),
            ElevatedButton(
              onPressed: _saveChecklist,
              child: const Text('Save Checklist'),
            ),
          ],
        ),
      ),
    );
  }
}
