import 'package:flutter/material.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future login({
    required String username,
    required String password,
    required String role,
  }) async {
    try {
      final response = await authRemoteDataSource.login(
        username: username,
        password: password,
        role: role,
      );
      if(response!=null&&response.statusCode==200){
        return response;
      }else{
        return response;
      }
    } catch (e) {
      debugPrint('Login error: ${e.toString()}');
    }
  }
}
