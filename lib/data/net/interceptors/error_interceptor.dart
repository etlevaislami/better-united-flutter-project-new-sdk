import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../util/ui_util.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err);
          case 401:
            throw UnauthorizedException(err);

          case 403:
            throw ForbiddenException(err);

          case 404:
            throw NotFoundException(err);
          case 409:
            throw ConflictException(err);
          case 500:
            throw InternalServerErrorException(err);
          default:
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        showToast("noInternetConnection".tr());
        throw NoInternetConnectionException(err);
    }

    return handler.next(err);
  }
}

class BadRequestException extends ExtendedDioError {
  late final String apiErrorCode;

  BadRequestException(DioError error) : super(error) {
    apiErrorCode = (error.response?.data as Map)["error"];
  }
}

class ExtendedDioError extends DioError {
  ExtendedDioError(DioError error)
      : super(
            requestOptions: error.requestOptions,
            response: error.response,
            error: error.error,
            type: error.type);

  @override
  String toString() {
    var msg = 'DioError [$type]: $message';
    if (error is Error) {
      msg += '\n${(error as Error).stackTrace}';
    }

    msg += "\nUrl:${requestOptions.uri}";

    if (type == DioErrorType.response) {
      msg += "\nAPI response:$response";
    }
    if (super.stackTrace != null) {
      msg += '\nSource stack:\n$stackTrace';
    }
    return msg;
  }
}

class InternalServerErrorException extends ExtendedDioError {
  InternalServerErrorException(DioError error) : super(error);
}

class ConflictException extends ExtendedDioError {
  ConflictException(DioError error) : super(error);
}

class UnauthorizedException extends ExtendedDioError {
  UnauthorizedException(DioError error) : super(error);
}

class ForbiddenException extends ExtendedDioError {
  late final String apiErrorCode;

  ForbiddenException(DioError error) : super(error) {
    apiErrorCode = (error.response?.data as Map)["error"];
  }
}

class NotFoundException extends ExtendedDioError {
  NotFoundException(DioError error) : super(error);
}

class NoInternetConnectionException extends ExtendedDioError {
  NoInternetConnectionException(DioError error) : super(error);
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}