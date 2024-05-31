import 'package:flutter/material.dart';
import 'package:take_off_checklist/models/checklist.dart';

class CreateChecklistScreen extends StatefulWidget {
  final Checklist? checklist;

  CreateChecklistScreen({this.checklist});

  @override
  _CreateChecklistScreenState createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  late TextEditingController _titleController;
  late List<TextEditingController> _itemControllers;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.checklist?.title ?? '');
    _itemControllers = widget.checklist?.items
            .map((item) => TextEditingController(text: item.description))
            .toList() ??
        [];
  }

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

  void _deleteItem(int index) {
    setState(() {
      _itemControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.checklist == null ? 'Create Checklist' : 'Edit Checklist'),
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
                  return ListTile(
                    title: TextField(
                      controller: _itemControllers[index],
                      decoration:
                          InputDecoration(labelText: 'Item ${index + 1}'),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItem(index);
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addChecklistItem,
              child: Text('Add Item'),
            ),
            ElevatedButton(
              onPressed: _saveChecklist,
              child: Text('Save Checklist'),
            ),
          ],
        ),
      ),
    );
  }
}
