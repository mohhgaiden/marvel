import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../model/series.dart';
part 'series_state.dart';
part 'series_cubit.freezed.dart';

class SeriesCubit extends Cubit<SeriesState> {
  SeriesCubit() : super(SeriesState.initial());

  String baseUrl = "https://gateway.marvel.com:443/v1/public";
  String publicKey = "61d583bb5a7df10e7f7e10378612a581";
  String privateKey = "118688024bbd221e024f6862e713108bd54ff927";
    
  String generateAuthParameters() {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5("$ts$privateKey$publicKey");
    return "ts=$ts&apikey=$publicKey&hash=$hash";
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = crypto.md5.convert(content);
    return hex.encode(digest.bytes);
  }

  getSeries(String id,String? param) async {
    try {
      emit(const SeriesState.loading());
      Dio dio = Dio();
      String url = '$baseUrl/characters/$id/series?${generateAuthParameters()}&limit=10';
      if (param != null) {
        url += param;
      }
      final response = await dio.get(url);
      if(response.statusCode==200){
        List<Series> series = response.data['data']['results'].map<Series>((e) {return Series.fromJson(e);}).toList();
        emit(SeriesState.success(series));
      }else{
        emit(SeriesState.error());
      }
    } catch (e) {
      emit(SeriesState.error());
    }
  }

}
