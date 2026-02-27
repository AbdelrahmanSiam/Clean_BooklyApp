import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});
  // Check if error from dio or not ? so if Dio error
  factory ServerFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: "Connection timeout with ApiServer");
      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: "Send timeout with ApiServer");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: "Receive timeout with ApiServer");
      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: "Bad certificate by ApiServer");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(e.response!.statusCode!, e.response);
      case DioExceptionType.cancel:
        return ServerFailure(errMessage: "Request by Api Service was canceled");
      case DioExceptionType.connectionError:
        return ServerFailure(
          errMessage: "No internet connection , Check you network connection",
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errMessage: "Oops there was an error , please try again later",
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic data) {
    if (statusCode == 404) {
      return ServerFailure(
        errMessage: "Your request was not found , please try again later",
      );
    } else if (statusCode >= 500) {
      return ServerFailure(
        errMessage: "There are problem with server , please try again later",
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {// token errors
      return ServerFailure(
        errMessage: data["error"]["message"],
      ); // depend on you api map
    } else {
      return ServerFailure(
        errMessage: "Oops there was an error , please try again later",
      );
    }
  }
}
