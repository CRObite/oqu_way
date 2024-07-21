import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/app_colors.dart';
import '../blocs/pagination_builder/pagination_builder_cubit/pagination_builder_cubit.dart';

class PaginationBuilder extends StatefulWidget {
  const PaginationBuilder({
    super.key,
    required this.size,
    required this.child,
    required this.type,
    this.cityId,
    this.specializationId,
    this.query = '',
    this.universityId,
    this.bottomSize = 0.0, this.onRefreshed,
  });

  final int size;
  final Widget Function(BuildContext, dynamic) child;
  final PageableType type;
  final int? universityId;
  final int? cityId;
  final int? specializationId;
  final String query;
  final double bottomSize;
  final VoidCallback? onRefreshed;

  @override
  State<PaginationBuilder> createState() => _PaginationBuilderState();
}

class _PaginationBuilderState extends State<PaginationBuilder> {
  late ScrollController scrollController;
  late PaginationBuilderCubit paginationBuilderCubit;

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    paginationBuilderCubit = PaginationBuilderCubit();

    // if(widget.type == PageableType.universities){
    //   paginationBuilderCubit.currentPageCount = 0;
    // }

    paginationBuilderCubit.getNewData(
      widget.size,
      widget.type,
      widget.universityId,
      widget.cityId,
      widget.specializationId,
      widget.query,
    );

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        if (paginationBuilderCubit.maxPage - 1 >= paginationBuilderCubit.currentPageCount + 1) {
          paginationBuilderCubit.currentPageCount ++;
          paginationBuilderCubit.getNewData(
            widget.size,
            widget.type,
            widget.universityId,
            widget.cityId,
            widget.specializationId,
            widget.query,
          );
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant PaginationBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.query != widget.query) {
      paginationBuilderCubit.resetPage(
        widget.size,
        widget.type,
        widget.universityId,
        widget.cityId,
        widget.specializationId,
        widget.query,
      );
    }

    if(oldWidget.cityId != widget.cityId){
      paginationBuilderCubit.resetPage(
        widget.size,
        widget.type,
        widget.universityId,
        widget.cityId,
        widget.specializationId,
        widget.query,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    paginationBuilderCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => paginationBuilderCubit,
      child: BlocListener<PaginationBuilderCubit, PaginationBuilderState>(
        listener: (context, state) {
          if(state is PaginationBuilderPushLogin){context.go('/loginPage');}
        },
        child: BlocBuilder<PaginationBuilderCubit, PaginationBuilderState>(
              builder: (context, state) {
                if (state is PaginationBuilderFetched) {
                  return RefreshIndicator(
                    onRefresh: () async {

                      if(widget.onRefreshed!= null){
                        widget.onRefreshed!();
                      }

                      paginationBuilderCubit.resetPage(
                        widget.size,
                        widget.type,
                        widget.universityId,
                        widget.cityId,
                        widget.specializationId,
                        widget.query,
                      );

                      print('refreshed');


                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: state.listOfValue.length + 1,
                      itemBuilder: (context, index) {
                        if (state.listOfValue.isNotEmpty) {
                          if (index < state.listOfValue.length) {
                            return widget.child(context, state.listOfValue[index]);
                          } else {


                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: paginationBuilderCubit.maxPage - 1 <= paginationBuilderCubit.currentPageCount
                                        ? Text(state.listOfValue.length < widget.size ? '' : 'Больше нет данных')
                                        : CircularProgressIndicator(color: AppColors.blueColor),
                                  ),
                                ),
                                SizedBox(height: widget.bottomSize),
                              ],
                            );
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  );
                } else if (state is PaginationBuilderLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.blueColor),
                  );
                } else if (state is PaginationBuilderError) {
                  return Center(
                    child: Text(state.errorText),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
      ),
    );
  }
}
