import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/services/service_locator.dart';

import '../features/authentication/domain/repository/auth_repository.dart';
import '../features/authentication/presentation/bloc/auth_bloc.dart';
class CampusOneApp extends StatelessWidget {
  const CampusOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (_) => AuthBloc(
    sl<AuthRepository>(),
  ),

  child: MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'CampusOne',

      theme: AppTheme.lightTheme,

      routerConfig: AppRouter.router,
  ),
    );
  }
}