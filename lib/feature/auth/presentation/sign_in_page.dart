import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/core/presentation/app_filled_button.dart';
import 'package:new_store/core/presentation/app_text_field.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  final AuthBloc _authBlock;
  const SignInPage({super.key, required AuthBloc authBlock})
      : _authBlock = authBlock;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthBloc get _bloc => widget._authBlock;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<String> error = ValueNotifier('');
  ValueNotifier isLoading = ValueNotifier(false);

  @override
  void dispose() {
    isLoading.dispose();
    error.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight / 3,
            ),
            AppTextField(
              textEditingController: nameController,
              labelText: 'Имя пользователя',
            ),
            const SizedBox(
              height: 10,
            ),
            AppTextField(
              textEditingController: passwordController,
              labelText: 'Пароль',
              isPassword: true,
            ),
            const SizedBox(
              height: 15,
            ),
            BlocListener<AuthBloc, AuthState>(
              bloc: _bloc,
              listener: (context, state) {
                switch (state) {
                  case AuthLoading():
                    isLoading.value = true;
                  case AuthSucces():
                    context.go(RouteList.account);
                  case AuthError(:final errorMessage):
                    {
                      error.value = errorMessage;
                      isLoading.value = false;
                    }
                  case Unknow():
                  // TODO: Handle this case.
                  case Authenticated():
                  // TODO: Handle this case.
                  case UnAuthenticated():
                  // TODO: Handle this case.
                  case LogoutSucces():
                  // TODO: Handle this case.
                }
              },
              child: ValueListenableBuilder(
                builder: (context, state, child) {
                  return AppFilledButton(
                    onTap: () async {
                      _bloc.add(LoginEvent(
                          username: nameController.text,
                          password: passwordController.text));
                    },
                    text: 'Войти',
                    isLoading: isLoading.value,
                  );
                },
                valueListenable: isLoading,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ValueListenableBuilder(
                valueListenable: error,
                builder: (context, state, child) {
                  return Text(
                    error.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.red),
                  );
                })
          ],
        ),
      ),
    );
  }
}
