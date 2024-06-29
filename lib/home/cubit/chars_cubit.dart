import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart' as crypto;

import '../model/chars.dart';
part 'chars_state.dart';
part 'chars_cubit.freezed.dart';

class CharsCubit extends Cubit<CharsState> {
  CharsCubit() : super(CharsState.initial());

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

  getChars(String? param) async {
    try{
      emit(const CharsState.loading());
      Dio dio = Dio();
      String url = '$baseUrl/characters?${generateAuthParameters()}&limit=10';
      if (param != null) {
        url += param;
      }
      final response = await dio.get(url);
      if(response.statusCode==200){
        List<Chars> chars = response.data['data']['results'].map<Chars>((e) {return Chars.fromJson(e);}).toList();
        emit(CharsState.success(chars));
      }else{
        emit(CharsState.error());
      }
    }catch(e){
      emit(const CharsState.error());
    }
  }
}
