import 'package:backend_hasura/home/models/user_model.dart';

abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingUserState extends UserState {}

class SuccessUserState extends UserState {
  final List<UserModel> users;

  SuccessUserState(this.users);
}

class ErrorUserState extends UserState {
  final String message;

  ErrorUserState(this.message);
}
