import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/feature/auth/domain/bloc/auth_bloc.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class SplashPage extends StatefulWidget {
  final AuthBloc _bloc;
  const SplashPage({super.key, required AuthBloc authBloc}) : _bloc = authBloc;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthBloc get _bloc => widget._bloc;
  @override
  void initState() {
    _bloc.add(CheckAuthEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _bloc,
      listener: (context, state) {
        switch (state) {
                case UnAuthenticated():context.go(RouteList.signIn) ;
                case Authenticated():context.go(RouteList.account) ; 
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: ColorCollection.primary,
          ),
        ),
      ),
    );
  }
}
