import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)

class UserModel extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  int age;

  UserModel({

    required this.name,

    required this.age,
  });
}