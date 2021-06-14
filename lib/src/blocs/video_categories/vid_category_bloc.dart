import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import '../../../src/blocs/video_categories/bloc.dart';
import '../../../src/models/category.dart';
import 'package:rxdart/rxdart.dart';

import '../../../src/resources/strings.dart';

class VidCategoryBloc extends Bloc<VidCategoriesEvent, VidCategoriesState> {
  final http.Client httpClient;

  VidCategoryBloc({@required this.httpClient}) : super(VidCategoriesInitial());

  @override
  Stream<Transition<VidCategoriesEvent, VidCategoriesState>> transformEvents(
    Stream<VidCategoriesEvent> events,
    TransitionFunction<VidCategoriesEvent, VidCategoriesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<VidCategoriesState> mapEventToState(VidCategoriesEvent event) async* {
    final currentState = state;
    if (event is VidCategoriesFetched) {
      try {
        if (currentState is VidCategoriesInitial) {
          print("******=========== am here in categories ==============******");
          final List categories = await _fetchCategories();
          yield VidCategoriesSuccess(
            categories: categories,
          );
          return;
        }
      } catch (_) {
        yield VidCategoriesFailure();
      }
    }
    if (event is VidCategoriesRefresh) {
      print("am refreshing");
      final List categories = await _fetchCategories();
      yield VidCategoriesSuccess(
        categories: categories,
      );
      return;
    }
  }

  Future<List> _fetchCategories() async {
    final response = await httpClient
        .get(AppStrings.primeURL + '?type=get_video_categories');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      List<Category> categories = CategoriesRepo.fromJson(data).categoryies;
      Category main =
          Category(id: 0, langKey: "All", english: "Home", type: "category");
      categories.insert(0, main);
      return categories;
    } else {
      throw Exception();
    }
  }
}
