import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/core/constant/app_color.dart';
import 'package:icd_teacher/core/error/error_state_widget.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/revision/ui/view/widget/custom_reviews_list_view.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
import 'package:icd_teacher/features/revision/ui/view_model/get_revisions_cubit/get_revisions_cubit.dart';

class RevisionItemPage extends StatelessWidget {
  const RevisionItemPage({super.key, required this.termModel});
  final TermModel termModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,

        title: const Text('المراجعة', style: TextStyle(fontFamily: 'Amiri')),
        centerTitle: true,
      ),
      body: BlocBuilder<GetRevisionsCubit, GetRevisionsState>(
        builder: (context, state) {
          if (state is GetRevisionsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetRevisionsError) {
            return ErrorStateWidget(message: state.errMessage);
          } else if (state is GetRevisionsSuccess) {
            final data = state.lessons;

            if (state.lessons.isEmpty) {
              return CustomNoItem(title: 'لا يوجد مراجعات حتي الان ');
            }
            return CustomRevisionsListView(data: data);
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
