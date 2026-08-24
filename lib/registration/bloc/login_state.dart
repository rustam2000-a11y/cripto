import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
  });

  final String email;
  final String password;
  final bool isLoading;

  LoginState copyWith({String? email, String? password, bool? isLoading}) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [email, password, isLoading];
}
