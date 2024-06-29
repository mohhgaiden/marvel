part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default('') String exceptionError,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _Initial;
}
