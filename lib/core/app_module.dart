import 'package:backend_hasura/home/controllers/app_controller.dart';
import 'package:backend_hasura/home/home_page.dart';
import 'package:backend_hasura/home/repositories/app_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart' hide Response;

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => HasuraConnect(
            "https://todo-list-project-backend.herokuapp.com/v1/graphql")),
        Bind((i) => AppRepository(i.get<HasuraConnect>())),
        Bind((i) => AppController(i.get<AppRepository>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const HomePage()),
      ];
}
