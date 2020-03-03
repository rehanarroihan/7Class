class LoginModel {
  bool success;
  String message;
  Data data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  Detail detail;
  String token;

  Data({this.detail, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    detail =
    json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Detail {
  int id;
  String authType;
  Null authId;
  String firstName;
  String lastName;
  String email;
  Null phone;
  Null contactType;
  int isEmailVerified;
  int isPhoneVerified;
  Null pictureUrl;
  String createdAt;
  String updatedAt;

  Detail(
      {this.id,
        this.authType,
        this.authId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.contactType,
        this.isEmailVerified,
        this.isPhoneVerified,
        this.pictureUrl,
        this.createdAt,
        this.updatedAt});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authType = json['auth_type'];
    authId = json['auth_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    contactType = json['contact_type'];
    isEmailVerified = json['is_email_verified'];
    isPhoneVerified = json['is_phone_verified'];
    pictureUrl = json['picture_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auth_type'] = this.authType;
    data['auth_id'] = this.authId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['contact_type'] = this.contactType;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['picture_url'] = this.pictureUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}