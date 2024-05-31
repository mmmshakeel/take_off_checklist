import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:take_off_checklist/models/checklist.dart';
import 'package:take_off_checklist/screens/checklist_screen.dart';
import 'package:take_off_checklist/screens/create_checklist_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Checklist> checklists = [];

  @override
  void initState() {
    super.initState();
    loadChecklists().then((loadedChecklists) {
      setState(() {
        checklists = loadedChecklists;
      });
    });
  }

  Future<void> saveChecklists(List<Checklist> checklists) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> checklistsJson =
        checklists.map((checklist) => jsonEncode(checklist.toJson())).toList();
    await prefs.setStringList('checklists', checklistsJson);
  }

  Future<List<Checklist>> loadChecklists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? checklistsJson = prefs.getStringList('checklists');
    if (checklistsJson != null) {
      return checklistsJson
          .map((json) => Checklist.fromJson(jsonDecode(json)))
          .toList();
    }
    return [];
  }

  void _addNewChecklist(Checklist checklist) {
    setState(() {
      checklists.add(checklist);
      saveChecklists(checklists);
    });
  }

  void _editChecklist(Checklist checklist, int index) {
    setState(() {
      checklists[index] = checklist;
      saveChecklists(checklists);
    });
  }

  void _deleteChecklist(int index) {
    setState(() {
      checklists.removeAt(index);
      saveChecklists(checklists);
    });
  }

  void _navigateToCreateChecklist(BuildContext context, {int? index}) async {
    final Checklist? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateChecklistScreen(
            checklist: index != null ? checklists[index] : null),
      ),
    );

    if (result != null) {
      if (index == null) {
        _addNewChecklist(result);
      } else {
        _editChecklist(result, index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Take Off Checklist'),
      ),
      body: ListView.builder(
        itemCount: checklists.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(checklists[index].title),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              _deleteChecklist(index);
            },
            child: ListTile(
              title: Text(checklists[index].title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChecklistScreen(
                      checklist: checklists[index],
                      onDelete: () => _deleteChecklist(index),
                    ),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _navigateToCreateChecklist(context, index: index);
                },
              ),
            ),
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
