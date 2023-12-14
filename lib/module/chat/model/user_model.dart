import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  UserModel({
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
  });
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['id'] = id;
    data['photoUrl'] = photoUrl;
    return data;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    email = json['email'];
    id = json['id'];
    photoUrl = json['photoUrl'];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [displayName, email, id, photoUrl];
}
