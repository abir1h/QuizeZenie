import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/app.dart';
import '../constants/common_imports.dart';

class Server {
  static final Server _s = Server._();
  late http.Client _client;
  static Server get instance => _s;
  Server._() {
    _client = http.Client();
  }

  final StreamController<String> _sessionExpireStreamController =
      StreamController.broadcast();
  Stream<String> get onUnauthorizedRequest =>
      _sessionExpireStreamController.stream;

  static String get host => ApiCredential
      .baseUrl; //TODO must check is HOST url active for production build

  Future<ServerResponse> postRequest(
      {required String url, required dynamic postData, String? token}) async {
    try {
      var body = json.encode(postData);
      var response = await _client.post(
        Uri.parse("$host/api/v1/$url"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": token == null
              ? "Bearer ${App.currentSession.tokens.accessToken}"
              : "Bearer $token"
        },
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");

      var jsonData = jsonDecode(response.body);
      if (response.statusCode != 401) {
        return ServerResponse.fromJson(jsonData);
      } else {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add(jsonData["message"]);
        }
        return ServerResponse(
            status: false, data: jsonData, message: jsonData["message"]);
      }
    } on SocketException catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection.");
    } on Exception catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred.");
    }
  }

  Future<ServerResponse> patchRequest(
      {required String url, required dynamic patchData, String? token}) async {
    try {
      var body = json.encode(patchData);
      var response = await _client.patch(
        Uri.parse("$host/api/v1/$url"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": token == null
              ? "Bearer ${App.currentSession.tokens.accessToken}"
              : "Bearer $token"
        },
        body: utf8.encode(body),
      );
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $body");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");

      var jsonData = jsonDecode(response.body);
      if (response.statusCode != 401) {
        return ServerResponse.fromJson(jsonData);
      } else {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add(jsonData["message"]);
        }
        return ServerResponse(
            status: false, data: jsonData, message: jsonData["message"]);
      }
    } on SocketException catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection.");
    } on Exception catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred.");
    }
  }

  Future<ServerResponse> getRequest(
      {required String url, String? token}) async {
    try {
      var response =
          await _client.get(Uri.parse("$host/api/v1/$url"), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token == null
            ? "Bearer ${App.currentSession.tokens.accessToken}"
            : "Bearer $token"
      });
      debugPrint(
          "REQUEST => ${response.request.toString()}\nRESPONSE DATA => ${response.body.toString()}");

      var jsonData = jsonDecode(response.body);
      if (response.statusCode != 401) {
        return ServerResponse.fromJson(jsonData);
      } else {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add(jsonData["message"]);
        }
        return ServerResponse(
            status: false, data: jsonData, message: jsonData["message"]);
      }
    } on SocketException catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection.");
    } on Exception catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred.");
    }
  }

  void uploadFile(
      {required String url,
      required File file,
       String? field='image',
      required void Function(ServerResponse response) onComplete}) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("$host/api/v1/$url"));
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer ${App.currentSession.tokens.accessToken}"
      });
      var attachedFile = await http.MultipartFile.fromPath('$field', file.path);
      request.files.add(attachedFile);
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          var jsonData = jsonDecode(value);
          onComplete(ServerResponse.fromJson(jsonData));
        });
      } else if (response.statusCode != 401) {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add("Session expired!");
        }
        onComplete(ServerResponse(
            status: false,
            data: "",
            message: "Upload failed! Unauthorized user."));
      } else {
        onComplete(ServerResponse(
            status: false,
            data: "",
            message: "Upload failed! Unknown error occurred."));
      }
    } on SocketException catch (_) {
      onComplete(ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection."));
    } on Exception catch (_) {
      onComplete(ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred."));
    }
  }

  void postRequestWithFiles(
      {required String url,
      required dynamic postData,
      required List<File> files,
      required void Function(ServerResponse response) onComplete}) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("$host/api/v1/$url"));
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer ${App.currentSession.tokens.accessToken}"
      });
      request.fields.addAll(postData);
      for (File file in files) {
        request.files.add(await http.MultipartFile.fromPath(
          'attachment_files[]',
          file.path,
        ));
      }
      // var response = await request.send();
      final response = await http.Response.fromStream(await request.send());
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $postData");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // response.stream.transform(utf8.decoder).listen((value) {
        //   var jsonData = json.decode(value);
        //   onComplete(ServerResponse.fromJson(jsonData));
        // });
        var jsonData = json.decode(response.body);
        onComplete(ServerResponse.fromJson(jsonData));
      } else if (response.statusCode == 413) {
        onComplete(ServerResponse(
            status: false, data: "", message: "Files are too large"));
      } else if (response.statusCode == 401) {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add("Session expired!");
        }
        onComplete(ServerResponse(
            status: false,
            data: "",
            message: "Upload failed! Unauthorized user."));
      } else {
        onComplete(ServerResponse(
            status: false,
            data: "",
            message: jsonDecode(response.body)["message"] ??
                "Request failed! Unknown error occurred."));
      }
    } on SocketException catch (_) {
      onComplete(ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection."));
    } on Exception catch (_) {
      onComplete(ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred."));
    }
  }

  Future<ServerResponse> postRequestWithFile({
    required String url,
    required dynamic postData,
    required String filePath,
  }) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("$host/api/v1/$url"));
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer ${App.currentSession.tokens.accessToken}"
      });
      request.fields.addAll(postData);
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      final response = await http.Response.fromStream(await request.send());
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $postData");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = json.decode(response.body);
        return ServerResponse.fromJson(jsonData);
      } else if (response.statusCode == 413) {
        return ServerResponse(
            status: false, data: "", message: "Files are too large");
      } else if (response.statusCode == 401) {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add("Session expired!");
        }
        return ServerResponse(
            status: false,
            data: "",
            message: "Upload failed! Unauthorized user.");
      } else {
        return ServerResponse(
            status: false,
            data: "",
            message: jsonDecode(response.body)["message"] ??
                "Request failed! Unknown error occurred.");
      }
    } on SocketException catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection.");
    } on Exception catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred.");
    }
  }

  Future<ServerResponse> postRequestWithFileProgress({
    required String url,
    required dynamic postData,
    required String filePath,
    required Function(double progress) onProgress,
  }) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse("$host/api/v1/$url"));
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer ${App.currentSession.tokens.accessToken}",
      });
      request.fields.addAll(postData);

      // Attach the file with progress tracking
      var file = File(filePath);
      var fileLength = await file.length();
      int bytesUploaded = 0;
      var stream = http.ByteStream(file.openRead().transform(
        StreamTransformer.fromHandlers(
          handleData: (chunk, sink) {
            sink.add(chunk);
            bytesUploaded += chunk.length;
            onProgress(bytesUploaded / fileLength);
          },
        ),
      ));
      var multipartFile = http.MultipartFile(
        'file',
        stream,
        fileLength,
        filename: filePath.split('/').last,
      );
      request.files.add(multipartFile);

      // Send the request
      final response = await http.Response.fromStream(await request.send());
      debugPrint("REQUEST => ${response.request.toString()}");
      debugPrint("REQUEST DATA => $postData");
      debugPrint("RESPONSE DATA => ${response.body.toString()}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = json.decode(response.body);
        return ServerResponse.fromJson(jsonData);
      } else if (response.statusCode == 413) {
        return ServerResponse(
            status: false, data: "", message: "Files are too large");
      } else if (response.statusCode == 401) {
        if (!_sessionExpireStreamController.isClosed) {
          _sessionExpireStreamController.sink.add("Session expired!");
        }
        return ServerResponse(
            status: false,
            data: "",
            message: "Upload failed! Unauthorized user.");
      } else {
        return ServerResponse(
            status: false,
            data: "",
            message: jsonDecode(response.body)["message"] ??
                "Request failed! Unknown error occurred.");
      }
    } on SocketException catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Check internet connection.");
    } on Exception catch (_) {
      return ServerResponse(
          status: false,
          data: _,
          message: "Request failed! Unknown error occurred.");
    }
  }

  void dispose() {
    _client.close();
    _sessionExpireStreamController.close();
  }
}

class ServerResponse {
  final dynamic data;
  final String message;
  final bool status;

  ServerResponse({this.data, required this.message, required this.status});

  factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
        status: json['success'] ?? false,
        message: json['message'] ?? "",
        data: json['data'],
      );
}
