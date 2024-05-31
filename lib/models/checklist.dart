class Checklist {
  String title;
  List<ChecklistItem> items;

  Checklist({required this.title, required this.items});

  Map<String, dynamic> toJson() => {
        'title': title,
        'items': items.map((item) => item.toJson()).toList(),
      };

  static Checklist fromJson(Map<String, dynamic> json) {
    return Checklist(
      title: json['title'],
      items: (json['items'] as List)
          .map((item) => ChecklistItem.fromJson(item))
          .toList(),
    );
  }
}

class ChecklistItem {
  String description;
  bool isChecked;

  ChecklistItem({required this.description, this.isChecked = false});

  Map<String, dynamic> toJson() => {
        'description': description,
        'isChecked': isChecked,
      };

  static ChecklistItem fromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      description: json['description'],
      isChecked: json['isChecked'],
    );
  }
}
