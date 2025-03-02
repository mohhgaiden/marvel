import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial()) {
    FirebaseAuth.instance.authStateChanges().listen((user) { 
      if(user == null){
        return emit(state.copyWith(isSignedIn: false));
      } else {
        emit(state.copyWith(isSignedIn: true));
      }
    });
  }
}
