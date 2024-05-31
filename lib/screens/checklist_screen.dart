import 'package:flutter/material.dart';
import 'package:take_off_checklist/models/checklist.dart';

class ChecklistScreen extends StatefulWidget {
  final Checklist checklist;
  final VoidCallback onDelete;

  ChecklistScreen({required this.checklist, required this.onDelete});

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

  void _deleteItem(int index) {
    setState(() {
      widget.checklist.items.removeAt(index);
    });
  }

  void _editItem(int index, String newItemDescription) {
    setState(() {
      widget.checklist.items[index].description = newItemDescription;
    });
  }

  void _addItem(String itemDescription) {
    setState(() {
      widget.checklist.items.add(ChecklistItem(description: itemDescription));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool allChecked = widget.checklist.items.every((item) => item.isChecked);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.checklist.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: widget.onDelete,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.checklist.items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextFormField(
                    initialValue: widget.checklist.items[index].description,
                    onChanged: (value) {
                      _editItem(index, value);
                    },
                  ),
                  leading: Checkbox(
                    value: widget.checklist.items[index].isChecked,
                    onChanged: (value) {
                      _toggleCheckItem(index);
                    },
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
          if (allChecked)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('All Checked!',
                  style: TextStyle(color: Colors.green, fontSize: 18)),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'New Item',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addItem(''); // Add a new empty item
                  },
                ),
              ),
              onFieldSubmitted: (value) {
                _addItem(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
