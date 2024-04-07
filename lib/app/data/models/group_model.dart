class Group {
  CreatedBy? createdBy;
  List<People>? people;

  Group({this.createdBy, this.people});

  Group.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'] != null
        ? CreatedBy?.fromJson(json['created_by'])
        : null;
    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people?.add(People.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (createdBy != null) {
      data['created_by'] = createdBy?.toJson();
    }
    if (people != null) {
      data['people'] = people?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  String? name;
  String? phoneNumber;
  String? uid;

  CreatedBy({this.name, this.phoneNumber, this.uid});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['uid'] = uid;
    return data;
  }
}

class People {
  String? name;
  List<String>? phoneNumbers;

  People({this.name, this.phoneNumbers});

  People.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumbers = json['phone_numbers']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone_numbers'] = phoneNumbers;
    return data;
  }
}
