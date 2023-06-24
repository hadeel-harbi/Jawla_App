import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api_constants.dart';

final box = GetStorage();
Future<Response> addImageResponse(File image) async {
  try {
    final getImage = await image.readAsBytes();
    var url = Uri.http(ApiALl().url, ApiALl().addImage);
    var response = await http.post(url,
        headers: {"authorization": box.read("token")}, body: getImage);

    return response;
  } on HttpException catch (error) {
    return Response(error.message, 111);
  } on ArgumentError catch (error) {
    return Response(error.message, 222);
  } on ClientException catch (error) {
    return Response(error.message, 333);
  } catch (error) {
    return Response("error", 444);
  }
}
