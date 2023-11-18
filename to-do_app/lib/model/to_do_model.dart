class ToDoModel {
  int? id;
  String? title;
  String? description;
  late bool? complete;

  ToDoModel({this.id, this.title, this.description});

  ToDoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    complete = json['complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['complete'] = complete;

    return data;
  }
}
