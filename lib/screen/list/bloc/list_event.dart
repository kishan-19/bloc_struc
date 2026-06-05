import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchData extends ListEvent{
  final bool isFirstTime;
  FetchData({this.isFirstTime = true});

  @override
  List<Object?> get props => [isFirstTime];
}