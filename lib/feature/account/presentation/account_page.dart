import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_store/feature/account/data/models/current_auth_model.dart';
import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class AccountPage extends StatefulWidget {
  final UserBloc _userBloc;
  final AuthBloc authBloc;

  const AccountPage({
    super.key,
    required UserBloc userBloc,
    required this.authBloc,
  }) : _userBloc = userBloc;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserBloc get _bloc => widget._userBloc;

  AuthBloc get _authBloc => widget.authBloc;
  @override
  void initState() {
    _bloc.add(GetCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _bloc,
        builder: (context, state) {
          return switch (state) {
            UserLoading() => const Center(
                child: CircularProgressIndicator(
                  color: ColorCollection.primary,
                ),
              ),
            UserError(:final errorMessage) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[ Text('Error: $errorMessage'),
                ElevatedButton(onPressed: (){
                  _bloc.add(GetCurrentUser());
                }, child: const Text('Go refresh'))]),
              ),
            UserSucces(:final user) => succesBuilder(user),
            // TODO: Handle this case.
            UserState() => throw UnimplementedError(),
          };
        },
      ),
    );
  }

  Widget succesBuilder(CurrentAuthModel user) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(user.firstName + user.lastName),
          actions: [
            IconButton(
                onPressed: () {
                  _authBloc.add(Logout());
                },
                icon: const Icon(Icons.exit_to_app_outlined))
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16).copyWith(top: 40),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 54,
                  backgroundImage: NetworkImage(
                    user.image,
                  ),
                  backgroundColor: const Color.fromARGB(255, 177, 177, 177),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(user.maidenName)
              ],
            ),
          ),
        ),
      );
}
