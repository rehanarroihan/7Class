class MyClassesModel {
  bool success;
  String message;
  List<Classes> data;

  MyClassesModel({this.success, this.message, this.data});

  MyClassesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Classes>();
      json['data'].forEach((v) {
        data.add(new Classes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classes {
  int id;
  String name;
  String code;
  String description;
  Null classPicture;
  Null classBanner;
  int createdBy;
  String createdAt;
  String updatedAt;

  Classes(
      {this.id,
        this.name,
        this.code,
        this.description,
        this.classPicture,
        this.classBanner,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  Classes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    classPicture = json['class_picture'];
    classBanner = json['class_banner'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['class_picture'] = this.classPicture;
    data['class_banner'] = this.classBanner;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}