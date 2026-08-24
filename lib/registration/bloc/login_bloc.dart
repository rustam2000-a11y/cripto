import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../data/repository/registration_repository.dart';
import 'login_effect.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends EffectBloc<LoginEvent, LoginState, LoginEffect> {
  LoginBloc({required RegistrationRepositoryI repository})
    : _repository = repository,
      super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
    on<LoginLoadingEvent>((event, emit) {
      emit(state.copyWith(isLoading: event.isLoading));
    });
    on<SignInWithEmailPressed>((event, emit) {
      _signInWithEmail();
    });
    on<SignInWithGooglePressed>((event, emit) {
      _signInWithGoogle();
    });
    on<SignInWithApplePressed>((event, emit) {
      _signInWithApple();
    });
  }

  final RegistrationRepositoryI _repository;

  Future<void> _signInWithEmail() async {
    add(const LoginLoadingEvent(isLoading: true));
    try {
      final user = await _repository.signInWithEmail(
        email: state.email,
        password: state.password,
      );
      add(const LoginLoadingEvent(isLoading: false));
      if (user != null) emitEffect(LoginSucceeded(user));
    } catch (e) {
      add(const LoginLoadingEvent(isLoading: false));
      emitEffect(LoginFailed(_describeError(e)));
    }
  }

  Future<void> _signInWithGoogle() async {
    add(const LoginLoadingEvent(isLoading: true));
    try {
      final user = await _repository.signInWithGoogle();
      add(const LoginLoadingEvent(isLoading: false));
      if (user != null) emitEffect(LoginSucceeded(user));
    } catch (e) {
      add(const LoginLoadingEvent(isLoading: false));
      emitEffect(LoginFailed(_describeError(e)));
    }
  }

  Future<void> _signInWithApple() async {
    add(const LoginLoadingEvent(isLoading: true));
    try {
      final user = await _repository.signInWithApple();
      add(const LoginLoadingEvent(isLoading: false));
      if (user != null) emitEffect(LoginSucceeded(user));
    } catch (e) {
      add(const LoginLoadingEvent(isLoading: false));
      emitEffect(LoginFailed(_describeError(e)));
    }
  }

  String _describeError(Object error) {
    if (error is FirebaseAuthException) {
      return error.message ?? error.code;
    }
    return error.toString();
  }
}
