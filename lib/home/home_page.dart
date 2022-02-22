import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/app_controller.dart';
import 'controllers/states/user_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    controller.getUser();
    controller.userNameTextController.addListener(() {
      controller.validateButton();
      setState(() {});
    });
    controller.userBioTextController.addListener(() {
      controller.validateButton();
      setState(() {});
    });
    super.initState();
  }

  final controller = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          if (value is LoadingUserState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value is SuccessUserState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: controller.userNameTextController,
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: controller.userBioTextController,
                      decoration: const InputDecoration(
                        labelText: 'BIO',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.validate
                        ? () async {
                            await controller.createUser();
                          }
                        : null,
                    child: const Text('Criar usuário'),
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      itemCount: value.users.length,
                      itemBuilder: (context, index) {
                        final user = value.users[index];
                        return ListTile(
                          leading: CircleAvatar(
                            child: IconButton(
                              onPressed: () async {
                                await controller.deleteUser(user.id!);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                          title: Text(user.name!),
                          subtitle: Text(user.bio!),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
