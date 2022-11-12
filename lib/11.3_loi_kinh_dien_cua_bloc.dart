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
      child: BlocBuilder<SearchBloc, SearchState>(
        buildWhen: (previous, current) => previous.text != current.text,
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) => InkWell(
              onTap: () => bloc.add(SearchEvent(context: context)),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text(state.text),
              ),
            ),
            itemCount: 30,
          );
        },
      ),
    );
  }
}

class SearchEvent {
  final BuildContext context;
  SearchEvent({required this.context});
}

class SearchState {
  final String text;

  SearchState({required this.text});
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(text: 'Init')) {
    on<SearchEvent>((event, emit) async {
      emit(SearchState(text: 'Loading'));
      try {
        await search();
        emit(SearchState(text: 'Search thành công'));
      } catch (e) {
        // thêm await là fix đc lỗi
        showDialog(
            context: event.context,
            builder: (context) {
              return AlertDialog(
                content: TextButton(
                  child: const Text('Lỗi!!'),
                  onPressed: () async {
                    await search(forceError: false);
                    emit(SearchState(text: 'Search lại thành công'));
                    Navigator.of(context).pop();
                  },
                ),
              );
            });
        print('Future completed!');
      }
    });
  }
}

Future<void> search({bool forceError = true}) async {
  if (forceError) {
    throw 'Lỗi search';
  }
}
