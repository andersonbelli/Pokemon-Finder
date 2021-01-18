import 'package:mobx/mobx.dart';
import 'package:pokemon_finder/view_models/user.viewmodel.dart';

part 'user.store.g.dart';

class UserStore = _UserStore with _$UserStore;

//  flutter packages pub run build_runner clean
//  flutter packages pub run build_runner build
abstract class _UserStore with Store {
  @observable
  UserViewModel userViewModel = UserViewModel();

  @action
  void setUser(UserViewModel user) {
    this.userViewModel = user;
  }
}
