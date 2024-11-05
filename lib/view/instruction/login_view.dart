import 'package:battari/view/instruction/register_view.dart';
import 'package:battari/view_model/user_form_view_model.dart';
import 'package:battari/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String error = "";
  @override
  Widget build(context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const Text("ログイン"),
            BattariUserFormWidgets.BattariIdField(),
            BattariUserFormWidgets.BattariPasswordField(),
            Consumer(builder: (context, ref, _) {
              return TextButton(
                onPressed: () async {
                  var result = formKey.currentState!.validate();
                  if (result) {
                    formKey.currentState!.save();
                    var isSuccess = await ref.read(userViewModelProvider.notifier).login();
                    if (isSuccess) {
                      context.push('/home');
                    } else {
                      error = "ログインに失敗しました";
                    }
                  }
                },
                child: const Text("ログイン"),
              );
            }),
            if (error.isNotEmpty)
              Text(
                error,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
