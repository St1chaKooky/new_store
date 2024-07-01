import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_store/core/domain/router/router.dart';
import 'package:new_store/feature/splash/domain/bloc/check_bloc.dart';
import 'package:new_store/theme/collections/colorCollection.dart';

class SplashPage extends StatefulWidget {
  final CheckBloc _bloc;
  const SplashPage({super.key, required CheckBloc checkBloc}) : _bloc = checkBloc;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  CheckBloc get _bloc => widget._bloc;
  @override
  void initState() {
    _bloc.add(CheckAuthUser());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckBloc, CheckState>(
      bloc: _bloc,
      listener: (context, state) {
        switch (state) {
                case CheckUnAuthSucces():context.go(RouteList.signIn) ;
                case CheckAuthSucces():context.go(RouteList.account) ; 
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
