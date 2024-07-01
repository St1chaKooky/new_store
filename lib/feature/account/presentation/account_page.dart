import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_store/feature/account/data/models/current_auth_model.dart';
import 'package:new_store/feature/account/domain/bloc/user_bloc.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class AccountPage extends StatefulWidget {
  final UserBloc _userBloc;
  const AccountPage({super.key, required UserBloc userBloc})
      : _userBloc = userBloc;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  UserBloc get _bloc => widget._userBloc;
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
                child: Text('Error: $errorMessage'),
              ),
            UserSucces(:final user) => succesBuilder(user),

            // TODO: Handle this case.
            UserState() => Container(),
          };
        },
      ),
    );
  }

  Widget succesBuilder(CurrentAuthModel user) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(user.firstName + user.lastName),
    ),
    body: SingleChildScrollView(
          padding: EdgeInsets.all(16).copyWith(top: 40),
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
                const SizedBox(height: 10,),
                Text(user.maidenName)
              ],
            ),
          ),
        ),
  );
}
