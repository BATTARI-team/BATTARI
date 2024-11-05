import 'package:battari/view_model/user_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final passwordNotifier = ValueNotifier<String>('');
    return Scaffold(
        body: OverflowBox(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          SizedBox(
            height: 180,
          ),
          Text(
            "新規登録",
            style: TextStyle(fontSize: 24),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                BattariUserFormWidgets.BattariIdField(),
                BattariUserFormWidgets.BattariPasswordField(
                    (value) => passwordNotifier.value = value),
                BattariUserFormWidgets.BattariRePasswordField(passwordNotifier),
                TextButton(
                  child: Text("次へ"),
                  onPressed: () {
                    var result = formKey.currentState!.validate();
                    if (result) {
                      formKey.currentState!.save();
                      context.push('/nickname');
                    }
                  },
                ),
                TextButton(onPressed: () => context.pop(), child: Text("戻る"))
              ],
            ),
          )
        ])));
  }
}

class BattariUserFormWidgets {
  static Widget BattariIdField() {
    return Consumer(builder: (context, ref, _) {
      return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "IDを入力してください";
          }
        },
        decoration: InputDecoration(
          prefixText: "@",
          labelText: "BATTARI-ID",
          hintText: "exampleID_BATTARI",
          isDense: false,
        ),
        onSaved: (value) => ref
            .read(userFormViewModelProvider.notifier)
            .changeBattariId(value!),
      );
    });
  }

  static Widget BattariPasswordField([ValueChanged<String>? onChanged]) {
    return Consumer(builder: (context, ref, _) {
      return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "パスワードを入力してください";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "パスワード",
          hintText: "password",
          isDense: false,
        ),
        onChanged: onChanged,
        onSaved: (value) =>
            ref.read(userFormViewModelProvider.notifier).changePassword(value!),
        obscureText: true,
      );
    });
  }

  static Widget BattariRePasswordField(ValueNotifier<String> passwordNotifier) {
    return ValueListenableBuilder<String>(
      valueListenable: passwordNotifier,
      builder: (context, password, child) {
        return TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "パスワードを入力してください";
            }
            if (value != password) {
              return "パスワードが一致しません";
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "パスワード(再入力)",
            hintText: "password",
            isDense: false,
          ),
          obscureText: true,
        );
      },
    );
  }

  static Widget BattariNicknameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "ニックネーム", hintText: "ニックネーム"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "ニックネームを入力してください";
        }
      },
    );
  }
}
