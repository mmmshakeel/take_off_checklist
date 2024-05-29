class Checklist {
  String title;
  List<ChecklistItem> items;

  Checklist({required this.title, required this.items});
}

class ChecklistItem {
  String description;
  bool isChecked;

  ChecklistItem({required this.description, this.isChecked = false});
}
