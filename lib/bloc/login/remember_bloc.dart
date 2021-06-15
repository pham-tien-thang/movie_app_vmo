import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../event/login/hidden_password.dart';
import 'package:movie_app_vmo/event/login/remember_event.dart';

class RememberBloc extends Bloc<remember, bool> {
  RememberBloc({checkbox}) : super(checkbox);
  bool _toggle() {
    bool state2;
    state2 = !state;
    print(state2);
    return state2;
  }

  @override
  Stream<bool> mapEventToState(remember event) async* {
    if (event == remember.check) {
      yield _toggle();
    }
  }


}
