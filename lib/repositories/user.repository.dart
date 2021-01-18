import 'package:pokemon_finder/interfaces/user.interface.dart';
import 'package:pokemon_finder/models/user.model.dart';
import 'package:pokemon_finder/repositories/database.repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository implements UserInterface {
  @override
  Future<int> register(User user) async {
    final Database db = await DatabaseRepository.getDatabase();

    Map<String, dynamic> userMap = user.toJson();

    return db.insert(DatabaseRepository.tableName, userMap);
  }

  @override
  Future<User> queryUser(String username) async {
    final Database db = await DatabaseRepository.getDatabase();

    final result = await db.query(
      DatabaseRepository.tableName,
      where: "${DatabaseRepository.username} = ?",
      whereArgs: [username],
      limit: 1,
    );

    return User.fromJson(result.first);
  }
}
