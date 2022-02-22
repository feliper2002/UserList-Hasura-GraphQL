import 'package:backend_hasura/home/repositories/app_repository.dart';
import 'package:flutter/material.dart';

import 'states/user_state.dart';

class AppController extends ValueNotifier<UserState> {
  AppController(this.repository) : super(InitialUserState());

  final AppRepository repository;

  Future<void> getUser() async {
    value = LoadingUserState();
    final users = await repository.getUser();
    value = SuccessUserState(users);
  }

  Future<void> deleteUser(String id) async {
    await repository.deleteUser(id);
    await getUser();
  }

  final userNameTextController = TextEditingController();
  final userBioTextController = TextEditingController();

  Future<void> createUser() async {
    await repository.createUser(
        userNameTextController.text, userBioTextController.text);
    await getUser();
    userNameTextController.clear();
    userBioTextController.clear();
  }

  bool validateButton() {
    return (userNameTextController.text.isNotEmpty &&
        userBioTextController.text.isNotEmpty);
  }

  bool get validate => validateButton();
}
