part of 'comics_cubit.dart';

@freezed
class ComicsState with _$ComicsState {
  const factory ComicsState.initial() = _Initial;
  const factory ComicsState.loading() = _Loading;
  const factory ComicsState.success(List<Comics> comics) = _Success;
  const factory ComicsState.error() = _Error;
}
