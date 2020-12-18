import 'package:mobx/mobx.dart';
import 'package:scriptkill/base/app_user.dart';
import 'package:scriptkill/model/UserModel.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  User user = AppUser.getUserLocalInfo();
  @action
  updataUser(User u) {
    user = u;
  }

  setName(String value) {
    user.nickname = value;
    user = user;
  }

  setAge(String value) {
    user.age = value;
    user = user;
  }

  setSex(String value) {
    user.sex = value;
    user = user;
  }

  setIntro(String value) {
    user.decs = value;
    user = user;
  }
}

UserStore $store = UserStore();
