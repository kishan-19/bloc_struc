import 'dart:convert';

import 'package:bloc_struc/constant/api_end_point.dart';
import 'package:bloc_struc/screen/list/model/ListResponseModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import 'list_event.dart';
import 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  int page = 1;
  static int pageLimit = 20;
  bool isLastPage = false;
  bool isFetching = false;
  List<ListData> users = [];

  ListBloc() : super(ListInitial()) {
    on<FetchData>((event, emit) async {
      if (isFetching || isLastPage) return;
      isFetching = true;
      try {
        if(event.isFirstTime == true){
          page = 1;
          users = [];
          isLastPage = false;
          emit(ListLoading());
        }else{
          emit(ListDataLoaded(listScreenData: users, isLoadMore: true,isLastPage: isLastPage));
        }


        final Map<String, String> jsonBody = {
          "limit": pageLimit.toString(),
          "page": page.toString(),
          "from_app": "true",
          "is_lwp": "false",
          "leave_age": "Full Day",
          "leave_half": "0",
          "total": "0",
          "status": "00",
        };

        final url = Uri.parse(listURl);

        final response = await http.post(url, body: jsonBody);
        final body = response.body;
        final statusCode = response.statusCode;
        Map<String, dynamic> data = jsonDecode(body);
        ListResponseModel dataResponse = ListResponseModel.fromJson(data);
        if (dataResponse.success == 1 && statusCode == 200) {
          List<ListData> tempList = dataResponse.listData ?? [];
          print(" $page  add data ${tempList.length}");

          if (tempList.isNotEmpty) {
            users.addAll(tempList);
            page++;

            if (tempList.length < pageLimit) {
              isLastPage = true;
            }
          } else {
            isLastPage = true;
          }
          print("daat length  ${users.length}");
          emit(ListDataLoaded(listScreenData: users, isLoadMore: false,isLastPage: isLastPage));
        } else {
          emit(
            ListDataError(
              error: dataResponse.message ?? "Something went wrong",
            ),
          );
        }
      } catch (e) {
        emit(ListDataError(error: "error $e"));
      }finally {
        isFetching = false;
      }
    });
  }
}
