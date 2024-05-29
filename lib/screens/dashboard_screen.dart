import 'package:flutter/material.dart';
import 'package:take_off_checklist/models/checklist.dart';
import 'package:take_off_checklist/screens/checklist_screen.dart';
import 'package:take_off_checklist/screens/create_checklist_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Checklist> checklists = [];

  void _addNewChecklist(Checklist checklist) {
    setState(() {
      checklists.add(checklist);
    });
  }

  void _navigateToCreateChecklist(BuildContext context) async {
    final Checklist? newChecklist = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateChecklistScreen()),
    );

    if (newChecklist != null) {
      _addNewChecklist(newChecklist);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Off Checklist'),
      ),
      body: ListView.builder(
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(checklists[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChecklistScreen(checklist: checklists[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateChecklist(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
