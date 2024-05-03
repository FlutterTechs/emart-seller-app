class Features {
  String? keyName;
  String? value;

  Features({this.keyName, this.value});

  Features.fromJson(Map<String, dynamic> json) {
    keyName = json['keyName'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keyName'] = this.keyName;
    data['value'] = this.value;
    return data;
  }
}