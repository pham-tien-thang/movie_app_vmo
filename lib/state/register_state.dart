import 'package:equatable/equatable.dart';
// extends Equatable
class RegisterState{
  String? errMail;
  String? errPassword;
  String? errPhone;
  String? errName;
  bool? isErrMail;
  bool? isErrPhone;
  bool? isErrPassword;
  bool? isErrName;
  bool? success;
  RegisterState(
      {this.errMail,
      this.errPassword,
      this.errPhone,
      this.errName,
      this.isErrName,
      this.isErrMail,
      this.isErrPassword,
      this.isErrPhone,
      this.success});

  // @override
  // // TODO: implement props
  // List<Object?> get props => [
  //       errMail,
  //       errPassword,
  //       errPhone,
  //       errName,
  //       isErrMail,
  //       isErrPhone,
  //       isErrPassword,
  //       isErrName,
  //       success,
  //     ];
}

class Success extends RegisterState {
  String? errMail;
  String? errPassword;
  String? errPhone;
  String? errName;
  bool? isErrMail;
  bool? isErrPhone;
  bool? isErrPassword;
  bool? isErrName;
  bool? success;
  Success(
      {this.errMail,
      this.errPassword,
      this.errPhone,
      this.errName,
      this.isErrName,
      this.isErrMail,
      this.isErrPassword,
      this.isErrPhone,
      this.success});
}

class Failure extends RegisterState {
  String? errMail;
  String? errPassword;
  String? errPhone;
  String? errName;
  bool? isErrMail;
  bool? isErrPhone;
  bool? isErrPassword;
  bool? isErrName;
  bool? success;
  Failure(
      {this.errMail,
      this.errPassword,
      this.errPhone,
      this.errName,
      this.isErrName,
      this.isErrMail,
      this.isErrPassword,
      this.isErrPhone,
      this.success});
}
