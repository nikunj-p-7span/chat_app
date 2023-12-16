import 'package:hive_flutter/hive_flutter.dart';

part 'UserDetail.g.dart';

@HiveType(typeId: 0)
class UserDetail {
  UserDetail({required this.uid});

  @HiveField(0)
  String uid;
}
