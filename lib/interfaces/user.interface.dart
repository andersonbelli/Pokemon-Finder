import 'package:pokemon_finder/models/user.model.dart';

abstract class UserInterface {
  Future<int> register(User user);

  Future<User> queryUser(String username);
}
