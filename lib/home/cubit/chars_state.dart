part of 'chars_cubit.dart';

@freezed
class CharsState with _$CharsState {
  const factory CharsState.initial() = _Initial;
  const factory CharsState.loading() = _Loading;
  const factory CharsState.success(List<Chars> char) = _Success;
  const factory CharsState.error() = _Error;
}
