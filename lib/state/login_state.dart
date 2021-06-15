import 'package:equatable/equatable.dart';
// extends Equatable
class LoginState{
  String? errPassword;
  String? errName;
  bool? isErrPassword;
  bool? isErrName;
  bool? success;
  LoginState(
      {
        this.errPassword,
        this.errName,
        this.isErrName,
        this.isErrPassword,
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

class SuccessLogin extends LoginState {
  String? errPassword;
  String? errName;
  bool? isErrPassword;
  bool? isErrName;
  bool? success;
  SuccessLogin(
      {
        this.errPassword,
        this.errName,
        this.isErrName,
        this.isErrPassword,
        this.success});
}

class FailureLogin extends LoginState {
  String? errPassword;
  String? errName;
  bool? isErrPassword;
  bool? isErrName;
  bool? success;
  FailureLogin(
      {
        this.errPassword,
        this.errName,
        this.isErrName,
        this.isErrPassword,
        this.success});
}
