part of 'list_bloc.dart';

@immutable
abstract class ListEvent extends Equatable {
  const ListEvent();
}

class LoadListEvent extends ListEvent {
  @override
  List<Welcome> get props => [];
}
