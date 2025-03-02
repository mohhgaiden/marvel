part of 'register_cubit.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default('') String exceptionError,
  }) = _Initial;
}
