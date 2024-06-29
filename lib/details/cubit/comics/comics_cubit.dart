import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../model/comics.dart';
part 'comics_state.dart';
part 'comics_cubit.freezed.dart';

class ComicsCubit extends Cubit<ComicsState> {
  ComicsCubit() : super(ComicsState.initial());

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

  getComics(String id,String? param) async {
    try {
      emit(const ComicsState.loading());
      Dio dio = Dio();
      String url = '$baseUrl/characters/$id/comics?${generateAuthParameters()}&limit=10';
      if (param != null) {
        url += param;
      }
      final response = await dio.get(url);
      if(response.statusCode==200){
        List<Comics> comics = response.data['data']['results'].map<Comics>((e) {return Comics.fromJson(e);}).toList();
        emit(ComicsState.success(comics));
      }else{
        emit(ComicsState.error());
      }
    } catch (e) {
      emit(ComicsState.error());
    }
  }
}
