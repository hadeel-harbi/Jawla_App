import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api_constants.dart';

final box = GetStorage();
Future<Response> displayOwnerActivities() async {
  try {
    var url = Uri.http(ApiALl().url, ApiALl().displayOwnerActivities);
    var response =
        await http.get(url, headers: {"authorization": box.read("token")});

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
