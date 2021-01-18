import 'package:meta/meta.dart';
import 'package:pokemon_finder/errors/failure.dart';
import 'package:pokemon_finder/interfaces/user.interface.dart';
import 'package:pokemon_finder/models/user.model.dart';
import 'package:pokemon_finder/repositories/user.repository.dart';
import 'package:pokemon_finder/view_models/user.viewmodel.dart';

class UserController implements UserInterface {
  final UserRepository repository;

  UserController({@required this.repository});

  Future<bool> validateUser(UserViewModel user) async {
    try {
      final User hasRegister = await queryUser(user.username);

      if (hasRegister == null) {
        await register(User(username: user.username));
      }
      return true;
    } catch (e) {
      throw e.toString();
      return false;
    }
  }

  @override
  Future<int> register(User user) async {
    try {
      return await repository.register(user);
    } catch (e) {
      print("RegisterError: " + e.toString());
      throw ServerFailure(message: e.toString()).message;
    }
  }

  @override
  Future<User> queryUser(String username) async {
    User user;
    try {
      user = await repository.queryUser(username);
    } catch (e) {
      print("QueryError: " + e.toString());
    }

    return user;
  }
}
