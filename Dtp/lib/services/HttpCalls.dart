import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:decisive_technology_products/models/response_model.dart';
import 'package:decisive_technology_products/utils/pref.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../s.dart';

// bool trustSelfSigned = true;
// HttpClient httpClient = new HttpClient()
//   ..badCertificateCallback = ((X509Certificate cert, String host, int port) => trustSelfSigned);
// IOClient ioClient = IOClient(httpClient);

class HttpCalls {
  static String live = "https://decisive-technology.com/";
  // static String live = "https://dtp.esolutionsprovider.com/";
  static String sServerURL = live;
  static String sStorageURL = (sServerURL) + 'storage/';

  static Uri getRequestURL(String postFix) {
    return Uri.parse(sServerURL + 'api/' + postFix);
  }

  static ViewResponse getDataObject(Response result) {
    Map userMap = jsonDecode(result.body);
    ViewResponse response =
        ViewResponse.fromJson(userMap as Map<String, dynamic>);
    return response;
  }

  static Future<ViewResponse> callGetApi(String endPoint,
      {bool hasAuth = true}) async {
    ViewResponse response;

    Uri url = HttpCalls.getRequestURL(endPoint);
    print(url);
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-localization': Pref.getPrefInt(Pref.language) == 0 ? 'en' : 'th',
    };

    if (hasAuth)
      header[HttpHeaders.authorizationHeader] =
          'Bearer ${S.sObjLogin != null ? S.sObjLogin!.token : ''}';

    var result;
    try {
      result = await http
          .get(
            url,
            headers: header,
          )
          .timeout(Duration(seconds: S.sTimeout));
      print(result);
      response = HttpCalls.getDataObject(result);
    } on TimeoutException catch (e) {
      print("$e 001");
      response = ViewResponse(message: e.toString(), statusCode: 'Timeout 001');
    } on HandshakeException catch (e) {
      print("$e 002");
      response = ViewResponse(
          message: e.toString(), statusCode: 'HandshakeException 002');
    } catch (e) {
      print("Exception $e 003");
      response = ViewResponse(message: e.toString(), statusCode: '003');
    }

    return response;
  }

  static Future<ViewResponse> callPostApi(String endPoint, Map params,
      {bool hasAuth = true, bool hasEncoded = true}) async {
    ViewResponse response;
    S.sFocusOut(g.Get.context!);
    print(params);
    Uri url = HttpCalls.getRequestURL(endPoint);
    print(url);
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-localization': Pref.getPrefInt(Pref.language) == 0 ? 'en' : 'th',
    };

    if (hasAuth)
      header[HttpHeaders.authorizationHeader] =
          'Bearer ${S.sObjLogin != null ? S.sObjLogin!.token : ''}';

    var result;
    try {
      result = await http
          .post(url, headers: header, body: utf8.encode(json.encode(params)))
          .timeout(Duration(seconds: S.sTimeout));
      print(result.body);
      response = HttpCalls.getDataObject(result);
      print('response: $response');
      print(response.data);
      print(response.message);
    } on TimeoutException catch (e) {
      print("$e 001");
      response = ViewResponse(message: e.toString(), statusCode: '001');
    } on HandshakeException catch (e) {
      print("$e 002");
      response = ViewResponse(message: e.toString(), statusCode: '002');
    } catch (e) {
      print("Exception $e 003");
      String error = e.toString();
      if (e.toString().contains('SocketException')) {
        error = 'seems like internet issue';
      }
      response = ViewResponse(message: error, statusCode: '003');
    }
    return response;
  }

  static Future<ViewResponse> callPutApi(String endPoint, Map params,
      {bool hasAuth = true, bool hasEncoded = true}) async {
    ViewResponse response;
    S.sFocusOut(g.Get.context!);

    print(params);
    Uri url = HttpCalls.getRequestURL(endPoint);
    print(url);
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-localization': Pref.getPrefInt(Pref.language) == 0 ? 'en' : 'th',
    };

    if (hasAuth)
      header[HttpHeaders.authorizationHeader] =
          'Bearer ${S.sObjLogin != null ? S.sObjLogin!.token : ''}';

    var result;
    try {
      result = await http
          .put(url, headers: header, body: utf8.encode(json.encode(params)))
          .timeout(Duration(seconds: S.sTimeout));
      print(result);
      response = HttpCalls.getDataObject(result);
      print('response: $response');
      print(response.data);
      print(response.message);
    } on TimeoutException catch (e) {
      print("$e 001");
      response = ViewResponse(message: e.toString(), statusCode: '001');
    } on HandshakeException catch (e) {
      print("$e 002");
      response = ViewResponse(message: e.toString(), statusCode: '002');
    } catch (e) {
      print("Exception $e 003");
      response = ViewResponse(message: e.toString(), statusCode: '003');
    }
    return response;
  }

  static Future<ViewResponse> callDeleteApi(String endPoint, Map? params,
      {bool hasAuth = true, bool hasEncoded = true}) async {
    ViewResponse response;
    S.sFocusOut(g.Get.context!);
    print(params);
    Uri url = HttpCalls.getRequestURL(endPoint);
    print(url);
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-localization': Pref.getPrefInt(Pref.language) == 0 ? 'en' : 'th',
    };

    if (hasAuth)
      header[HttpHeaders.authorizationHeader] =
          'Bearer ${S.sObjLogin != null ? S.sObjLogin!.token : ''}';

    try {
      final request = Request("DELETE", url);
      request.headers.addAll(header);
      request.body = jsonEncode(params);
      var streamedResponse = await request.send();
      var result = await Response.fromStream(streamedResponse);
      print(result.body);
      response = HttpCalls.getDataObject(result);
      print('response: $response');
      print(response.data);
      print(response.message);
    } on TimeoutException catch (e) {
      print("$e 001");
      response = ViewResponse(message: e.toString(), statusCode: '001');
    } on HandshakeException catch (e) {
      print("$e 002");
      response = ViewResponse(message: e.toString(), statusCode: '002');
    } catch (e) {
      print("Exception $e 003");
      response = ViewResponse(message: e.toString(), statusCode: '003');
    }
    return response;
  }

  static Future<ViewResponse> uploadFile(
      String endPoint, Map<String, String> files,
      {bool isUserAvatar = false,
      bool hasAuth = true,
      Map<String, String>? params}) async {
    ViewResponse response = new ViewResponse();
    S.sFocusOut(g.Get.context!);
    Uri url = HttpCalls.getRequestURL(endPoint);
    print(url);
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'X-localization': Pref.getPrefInt(Pref.language) == 0 ? 'en' : 'th',
    };

    if (hasAuth)
      header[HttpHeaders.authorizationHeader] =
          'Bearer ${S.sObjLogin != null ? S.sObjLogin!.token : ''}';
    try {
      var request = MultipartRequest(
        'POST',
        url,
      );

      request.headers.addAll(header);
      if (params != null) {
        print(params);
        request.fields.addAll(params);
      }
      print(files);
      files.entries.forEach((element) async {
        request.files
            .add(await MultipartFile.fromPath(element.key, element.value));
      });
      var streamedResponse = await request.send();
      var result = await Response.fromStream(streamedResponse);
      print(result.body);
      response = HttpCalls.getDataObject(result);
      return response;
    } catch (e) {
      print(e.toString());
      S.sSnackBar(title: 'Error', message: e.toString());
    }
    return response;
  }

  static Future addImages(Map<String, String> files) async {
    return files.entries.forEach((element) async {
      await MultipartFile.fromPath(element.key, element.value);
    });
  }
}
