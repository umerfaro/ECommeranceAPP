class categoryModel {
  List<Categories>? categories;

  categoryModel({this.categories});

  categoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? name;
  List<String>? subcategory;

  Categories({this.name, this.subcategory});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subcategory = json['subcategory'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subcategory'] = this.subcategory;
    return data;
  }
}
