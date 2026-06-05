import 'package:bloc_struc/screen/list/model/ListResponseModel.dart';
import 'package:equatable/equatable.dart';

abstract class ListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ListInitial extends ListState{}
class ListLoading extends ListState{}

class ListDataLoaded  extends ListState{
  final List<ListData> listScreenData;
  final bool isLoadMore;
  final bool isLastPage;
  ListDataLoaded({required this.listScreenData,required this.isLoadMore,required this.isLastPage});

  @override
  List<Object?> get props => [
    listScreenData,
    isLoadMore,
  ];
}

class ListDataError extends ListState{
  final String error;
  ListDataError({required this.error});

  @override
  List<Object?> get props => [error];
}