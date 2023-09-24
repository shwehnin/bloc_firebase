import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_firebase/app/bloc/bloc_event.dart';
import 'package:bloc_firebase/app/bloc/bloc_state.dart';

class BlocPage extends Bloc<BlocEvent, BlocState> {
  BlocPage() : super(InitialState()) {
    on<BlocEvent>((event, emit) {
      if (event is LoginEvent) {
        emit(LoginState());
      } else if (event is RegisterEvent) {
        emit(RegisterState());
      } else if (event is HomeEvent) {
        emit(HomeState());
      } else if (event is NewPostEvent) {
        emit(NewPostState());
      } else if (event is PostEvent) {
        emit(PostState());
      }
    });
  }
}
