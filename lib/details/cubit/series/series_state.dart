part of 'series_cubit.dart';

@freezed
class SeriesState with _$SeriesState {
  const factory SeriesState.initial() = _Initial;
  const factory SeriesState.loading() = _Loading;
  const factory SeriesState.success(List<Series> comics) = _Success;
  const factory SeriesState.error() = _Error;
}
