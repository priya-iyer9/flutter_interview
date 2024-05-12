import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_interview/models/list_model.dart';
import 'package:flutter_interview/repository/list_repository.dart';
import 'package:meta/meta.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  final ListRepository _listRepository;

  ListBloc(this._listRepository) : super(ListLoadingState()) {
    on<LoadListEvent>((event, emit) async {
      emit(ListLoadingState());
      try {
        final list = await _listRepository.getListApi();
        emit(ListLoadedState(list));
      } catch (e) {
        // emit(ListErrorState(e.toString()));
      }
    });
  }
}
