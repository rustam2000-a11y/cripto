import 'package:equatable/equatable.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
  });

  final String name;
  final String email;
  final String password;
  final bool isLoading;

  RegistrationState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLoading,
  }) {
    return RegistrationState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [name, email, password, isLoading];
}
