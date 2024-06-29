import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.initial());

  void signUpWithCredentials(String email,password) async {
    try {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
        exceptionError: error.message.toString(),
        status: FormzSubmissionStatus.failure
      ));
    } on PlatformException catch (error) {
      emit(state.copyWith(
        exceptionError: error.message.toString(),
        status: FormzSubmissionStatus.failure
      ));
    } catch (error) {
      emit(state.copyWith(
        exceptionError: "Unexpected error please try again later",
        status: FormzSubmissionStatus.failure
      ));
    }
  }
}
