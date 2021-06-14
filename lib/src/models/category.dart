class CategoriesRepo {
  String apiStatus;
  String apiVersion;
  String message;
  List<Category> categoryies;

  CategoriesRepo(
      {this.apiStatus, this.apiVersion, this.message, this.categoryies});

  CategoriesRepo.fromJson(Map<String, dynamic> json) {
    apiStatus = json['api_status'];
    apiVersion = json['api_version'];
    message = json['message'];
    if (json['categoryies'] != null) {
      categoryies = <Category>[];
      json['categoryies'].forEach((v) {
        categoryies.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_status'] = this.apiStatus;
    data['api_version'] = this.apiVersion;
    data['message'] = this.message;
    if (this.categoryies != null) {
      data['categoryies'] = this.categoryies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String langKey;
  String type;
  String english;

  Category({this.id, this.langKey, this.type, this.english});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    langKey = json['lang_key'];
    type = json['type'];
    english = json['english'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lang_key'] = this.langKey;
    data['type'] = this.type;
    data['english'] = this.english;
    return data;
  }
}