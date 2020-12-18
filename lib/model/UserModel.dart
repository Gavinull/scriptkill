class User {
  String unionid;
  String openid;

  String id;
  String nickname;
  String headimgurl;
  String decs;
  String sex;
  String age;
  String level;
  String honor;

  String country;
  String province;
  String city;

  User({
    this.id,
    this.unionid,
    this.openid,
    this.nickname,
    this.headimgurl,
    this.decs,
    this.sex,
    age,
    this.country,
    this.province,
    this.city,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = (json['id'] != null) ? json['id'].toString() : "911911911";
    unionid = (json['unionid'] != null) ? json['unionid'].toString() : "";
    openid = (json['openid'] != null) ? json['openid'].toString() : "";
    nickname = (json['nickname'] != null) ? json['nickname'].toString() : "";
    headimgurl =
        (json['headimgurl'] != null) ? json['headimgurl'].toString() : "";
    decs = (json['decs'] != null)
        ? json['decs'].toString()
        : "戏精本精戏精本精戏精本精戏精本精戏精本精戏精本精戏精本精";
    sex = (json['sex'] != null) ? json['sex'].toString() : "";
    age = (json['age'] != null) ? json['age'].toString() : "";

    level = (json['level'] != null) ? json['level'].toString() : "S";
    honor = (json['honor'] != null) ? json['honor'].toString() : "250";
    country = (json['country'] != null) ? json['country'].toString() : "";
    province = (json['province'] != null) ? json['province'].toString() : "";
    city = (json['city'] != null) ? json['city'].toString() : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unionid'] = this.unionid;
    data['openid'] = this.openid;
    data['nickname'] = this.nickname;
    data['headimgurl'] = this.headimgurl;
    data['decs'] = this.decs;
    data['sex'] = this.sex;
    data['age'] = this.age;

    data['level'] = this.level;
    data['honor'] = this.honor;
    data['country'] = this.country;
    data['province'] = this.province;
    data['city'] = this.city;

    return data;
  }
}
