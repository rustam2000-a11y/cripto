import 'package:bloc_after_effect/bloc_after_effect.dart';
import 'package:flutter/material.dart';

import '../home/home_widget/custom_app_bar.dart';
import '../injection.dart';
import '../presentation/app_colors.dart';
import 'bloc/insight_bloc.dart';
import 'bloc/insight_effect.dart';
import 'bloc/insight_event.dart';
import 'bloc/insight_state.dart';
import 'insight_widgets/insight_card.dart';

class InsightScreen extends StatefulWidget {
  const InsightScreen({super.key});

  @override
  State<InsightScreen> createState() => _InsightScreenState();
}

class _InsightScreenState extends State<InsightScreen> {
  late final InsightBloc _bloc;

  @override
  void initState() {
    _bloc = getIt<InsightBloc>()..add(const LoadInsightsEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.haiti,
      appBar: CustomAppBar(text: 'AI-аналитика', leadingIcon: false),
      body: BlocEffectBuilder<InsightBloc, InsightState, InsightEffect>(
        bloc: _bloc,
        effectListener: (context, effect) {
          switch (effect) {
            case InsightShowError(message: final message):
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.insights.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.errorMessage ??
                          'Нет данных для AI-аналитики по топ-10 монетам',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => _bloc.add(const LoadInsightsEvent()),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.insights.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              return InsightCard(insight: state.insights[index]);
            },
          );
        },
      ),
    );
  }
}
