import 'package:hive/hive.dart';
import 'model/user_model.dart';

class HiveService {

  static const String boxName =
      "userBox";

  /// GET BOX
  Box<UserModel> get box =>
      Hive.box<UserModel>(boxName);

  /// ADD
  Future<void> addUser(
      UserModel user,
      ) async {

    await box.add(user);
  }

  /// GET
  List<UserModel> getUsers() {

    return box.values.toList();
  }

  /// UPDATE
  Future<void> updateUser({

    required int index,

    required UserModel user,

  }) async {

    await box.putAt(index, user);
  }

  /// DELETE
  Future<void> deleteUser(
      int index,
      ) async {

    await box.deleteAt(index);
  }
}