import 'dart:convert';

import 'package:backend_hasura/home/models/user_model.dart';
import 'package:hasura_connect/hasura_connect.dart';

class AppRepository {
  AppRepository(this.connect);

  final HasuraConnect connect;

  Future<List<UserModel>> getUser() async {
    var query = '''
query {
  users {
    id
    name
    bio
  }
}
      ''';
    final response = await connect.query(query);
    final users = response['data']['users'];

    final lista = <UserModel>[];

    for (var user in users) {
      final json = jsonEncode(user);
      lista.add(UserModel.fromJson(json));
    }
    return lista;
  }

  Future<void> createUser(String name, String bio) async {
    var query = '''
 mutation {
  insert_users(objects: {name: "$name", bio: "$bio"}) {
    affected_rows
    returning {
      id
      name
      bio
    }
  }
}
      ''';

    await connect.mutation(query);
  }

  Future<void> deleteUser(String id) async {
    var query = '''
mutation {
  delete_users_by_pk(id: "$id") {
    id
  }
}
      ''';

    await connect.mutation(query);
  }
}
