class userModel {
  String? name;
  String? email;
  String? password;
  String? userId;
  String? shopGst;

  userModel({this.name, this.email, this.password, this.userId, this.shopGst});

  userModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    userId = json['user_id'];
    shopGst = json['shop_gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['user_id'] = this.userId;
    data['shop_gst'] = this.shopGst;
    return data;
  }
}