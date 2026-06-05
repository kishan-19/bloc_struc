import 'package:bloc_struc/constant/color.dart';
import 'package:bloc_struc/widgets/coommon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utiles/util.dart';
import '../../widgets/LoadingMoreWidget.dart';
import 'bloc/list_bloc.dart';
import 'bloc/list_event.dart';
import 'bloc/list_state.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  final ScrollController scrollController =
  ScrollController();


  @override
  void initState() {
    context.read<ListBloc>().add(FetchData());

    scrollController.addListener(() {
      pagination();
    });

    super.initState();
  }

  void pagination() {
    final bloc = context.read<ListBloc>();
    if (!bloc.isLastPage && !bloc.isFetching && bloc.users.isNotEmpty) {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        bloc.add(
          FetchData(isFirstTime: false),
        );
      }
    }
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.2,
        title: Text("List",style: getMediumTextStyle(),),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: BlocConsumer<ListBloc, ListState>(
          listener: (context,state){
            if (state is ListDataError) {
              return showSnackBar(state.error, context);
            }
          },
          builder: (context, state) {
            if (state is ListLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.black,));
            }
            // print(state is ListMoreData && (state.isLoadMore ==false ));
            if(state is ListDataLoaded){
              return Column(
                children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.listScreenData.length,
                    itemBuilder: (listContext, index) {
                      final data = state.listScreenData[index];
                      return ListTile(
                        leading: Text(data.leaveRequestID ?? ""),
                        title: Text(data.empName ?? ""),
                        subtitle: Text(data.reason ?? ""),);
                    },),
                ),
                  Visibility(
                      visible: state.isLoadMore && !state.isLastPage,
                      child: LoadingMoreWidget()
                  )
                ]
              );
            }
            return const SizedBox();
          }
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    context.read<ListBloc>().add(
      FetchData(),
    );
  }
}
