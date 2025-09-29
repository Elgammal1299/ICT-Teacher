import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/tram_grade_model.dart';
import 'package:icd_teacher/features/revision/ui/view/widget/custom_reviews_list_view.dart';
import 'package:icd_teacher/features/lessons/ui/view/widget/custom_no_lesson.dart';
import 'package:icd_teacher/features/revision/ui/view_model/get_revisions_cubit/get_revisions_cubit.dart';

class RevisionItemPage extends StatelessWidget {
  const RevisionItemPage({super.key, required this.termModel});
  final TermModel termModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المراجعة')),
      body: BlocBuilder<GetRevisionsCubit, GetRevisionsState>(
        builder: (context, state) {
          if (state is GetRevisionsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetRevisionsError) {
            return Center(child: Text(state.errMessage));
          } else if (state is GetRevisionsSuccess) {
            final data = state.lessons;

            if (state.lessons.isEmpty) {
              return const CustomNoLesson();
            }
            return CustomRevisionsListView(data: data);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
