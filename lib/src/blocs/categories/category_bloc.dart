import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:newsapp/src/blocs/article/bloc.dart';
import 'package:newsapp/src/blocs/categories/bloc.dart';
import 'package:newsapp/src/models/category.dart';
import 'package:rxdart/rxdart.dart';

import 'package:newsapp/src/resources/strings.dart';

class CategoryBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final http.Client httpClient;

  CategoryBloc({@required this.httpClient}) : super(CategoriesInitial());

  @override
  Stream<Transition<CategoriesEvent, CategoriesState>> transformEvents(
    Stream<CategoriesEvent> events,
    TransitionFunction<CategoriesEvent, CategoriesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    final currentState = state;
    if (event is CategoriesFetched) {
      try {
        if (currentState is CategoriesInitial) {
          print("******=========== am here in categories ==============******");
          final List categories = await _fetchCategories();
          yield CategoriesSuccess(
            categories: categories,
          );
          return;
        }
      } catch (_) {
        yield CategoriesFailure();
      }
    }
    if (event is CategoriesRefresh) {
      print("am refreshing");
      final List categories = await _fetchCategories();
      yield CategoriesSuccess(
        categories: categories,
      );
      return;
    }
  }

  Future<List> _fetchCategories() async {
    final response = await httpClient.get(AppStrings.primeURL +
        '?type=get_categories');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List<Category> categories = CategoriesRepo.fromJson(data).categoryies;
      Category main = Category(id: 0,langKey: "All",english:"Home",type: "category");
      categories.insert(0, main);
      return categories;
    } else {
      throw Exception();
    }
  }
}
