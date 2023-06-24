import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api_constants.dart';

Future<Response> updatePassword({required Map body}) async {
  try {
    var url = Uri.http(ApiALl().url, ApiALl().updatePassword);
    var response = await http.post(url, body: json.encode(body));

    return response;
  } on HttpException catch (error) {
    return Response(error.message, 111);
  } on ArgumentError catch (error) {
    return Response(error.message, 222);
  } on ClientException catch (error) {
    return Response(error.message, 333);
  } catch (error) {
    return Response("$error", 444);
  }
}
