import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MaterialApp(
      home: Scaffold(
    body: SafeArea(child: SearchPage()),
  )));
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: RefreshIndicator(
        onRefresh: () {
          final completer = Completer<void>();
          bloc.add(SearchEvent(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (previous, current) => previous.text != current.text,
          builder: (context, state) {
            return ListView.builder(
              itemBuilder: (context, index) => Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(state.text),
              ),
              itemCount: 30,
            );
          },
        ),
      ),
    );
  }
}

class SearchEvent {
  final Completer<void> completer;

  SearchEvent({required this.completer});
}

class SearchState {
  final String text;

  SearchState({required this.text});
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(text: 'Init')) {
    on<SearchEvent>((event, emit) async {
      emit(SearchState(text: 'Loading'));
      await Future.delayed(const Duration(seconds: 3));
      event.completer.complete();
      emit(SearchState(text: 'Refresh thành công!'));
    });
  }
}
