import 'package:flutter_bloc/flutter_bloc.dart';
import '../../event/login/hidden_password.dart';

class PassWordBloc extends Bloc<HiddenPassword, bool> {
  PassWordBloc({obscuretext}) : super(obscuretext);
  bool _toggle() {
    bool state2;
   state2 = !state;
   print(state2);
    return state2;
  }

  @override
  Stream<bool> mapEventToState(HiddenPassword event) async* {
    if (event == HiddenPassword.hidden) {
      yield _toggle();
    }
  }


}
