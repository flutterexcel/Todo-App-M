import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/bloc/home_bloc/home_event.dart';
import 'package:todo_app/bloc/home_bloc/home_state.dart';
import 'package:todo_app/utils/google_authentication.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<PersonalTaskEvent>((event, emit) async {
      List<dynamic> list = await getData(event.categoryType);
      emit(CategoryTaskState(list));
    });

    on<SchoolTaskEvent>((event, emit) async {
      List<dynamic> list = await getData(event.categoryType);
      emit(CategoryTaskState(list));
    });

    on<HomeTaskEvent>((event, emit) async {
      List<dynamic> list = await getData(event.categoryType);
      emit(CategoryTaskState(list));
    });

    on<WorkTaskEvent>((event, emit) async {
      List<dynamic> list = await getData(event.categoryType);
      emit(CategoryTaskState(list));
    });

    on<AllTaskEvent>((event, emit) async {
      List<dynamic> list = await allGetData();
      emit(CategoryTaskState(list));
    });

    on<GoogleSignOutEvent>((event, emit) async {
      await signOut(context: event.context);
      emit(GoogleSignOutState());
    });
  }

  Future<List<dynamic>> getData(category) async {
    //use a Async-await function to get the data
    final list = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .where('category', isEqualTo: '$category')
        .get();
    List doct = list.docs;
    return doct;
  }

  Future<List<dynamic>> allGetData() async {
    //use a Async-await function to get the data
    final list = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        // .where('category', isEqualTo: '$category')
        .get();
    List doct = list.docs;
    return doct;
  }
}
