class UserModel {
  bool success;
  String message;
  UserDataModel data;

  UserModel({this.success, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UserDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserDataModel {
  String authType;
  String firstName;
  Null lastName;
  String email;
  String updatedAt;
  String createdAt;
  int id;

  UserDataModel(
      {this.authType,
        this.firstName,
        this.lastName,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    authType = json['auth_type'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth_type'] = this.authType;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
