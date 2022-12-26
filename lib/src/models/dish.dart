import 'dart:convert';
import 'dart:developer';

List<Dish> dishFromJson(String str) =>
    List<Dish>.from(json.decode(str).map((x) => Dish.fromJson(x)));

class Dish {
  int? id;
  String? name;
  String? description;
  String? img_path;

  Dish({this.id, this.name, this.description, this.img_path});

  Dish.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    img_path = json['img_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['img_path'] = img_path;
    return data;
  }
  @override
  String toString() { 
    return "id:$id-name:$name-description:$description-img_path:$img_path";
  }
}