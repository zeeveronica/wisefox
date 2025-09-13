// //lessons
// import 'package:wisefox/affiliate/bloc/auth_event.dart';
// import 'package:wisefox/affiliate/bloc/auth_state.dart';
// import 'package:bloc/bloc.dart';

// class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
//   final UpcommingRepo _classesRepository;
//   final CompletedRepo _completedRepo;
//   final CancellRepo _cancellRepo;
//   // Constructor initializes the BLoC with a repository and sets up event handlers
//   ClassesBloc(this._classesRepository, this._completedRepo, this._cancellRepo)
//       : super(ClassesInitial()) {
//     on<FetchUpcomingClasses>(_onFetchUpcomingClasses);
//     on<FetchClassesForDate>(_onFetchClassesForDate);
//     on<FetchCompletedClasses>(_onFetchCompletedClasses);
//     on<FetchCompletedForDate>(_onFetchCompletedForDate);
//     on<FetchCancellClasses>(_onFetchCancell);
//     on<FetchCancellForDate>(_onFetchCancellForDate);
//   }

//   // Handler for FetchUpcomingClasses event
//   Future<void> _onFetchUpcomingClasses(
//       FetchUpcomingClasses event, Emitter<ClassesState> emit) async {
//     emit(ClassesLoading()); // Emit loading state

//     try {
//       // Fetch upcoming classes from repository
//       final classes = await _classesRepository.Upcommingclasses();
//       emit(ClassesLoaded(classes)); // Emit loaded state with data
//     } catch (e) {
//       emit(ClassesError(
//           e.toString())); // Emit error state if something goes wrong
//     }
//   }

//   Future<void> _onFetchClassesForDate(
//       FetchClassesForDate event, Emitter<ClassesState> emit) async {
//     emit(ClassesLoading());

//     try {
//       // Format the date as 'yyyy-MM-dd'
//       final dateStr = DateFormat('yyyy-MM-dd').format(event.date);

//       // Fetch classes for the formatted date
//       final classes = await _classesRepository.getClassesForDate(dateStr);

//       // Emit the loaded state with the fetched classes
//       emit(ClassesLoaded(classes));
//     } catch (e) {
//       // Emit an error state with the error message
//       emit(ClassesError(e.toString()));
//     }
//   }

//   Future<void> _onFetchCompletedClasses(
//       FetchCompletedClasses event, Emitter<ClassesState> emit) async {
//     emit(CompletedClassLoading());

//     try {
//       final classes = await _completedRepo.Completedclasses('completed');
//       emit(CompletedClassLoaded(classes));
//     } catch (e) {
//       emit(CompletedClassesError(e.toString()));
//     }
//   }

//   Future<void> _onFetchCompletedForDate(
//       FetchCompletedForDate event, Emitter<ClassesState> emit) async {
//     emit(CompletedClassLoading());

//     try {
//       final dateStr = DateFormat('yyyy-MM-dd').format(event.date);
//       final classes =
//           await _completedRepo.getClassescompletedForDate(dateStr, 'completed');
//       emit(CompletedClassLoaded(classes));
//     } catch (e) {
//       emit(CompletedClassesError(e.toString()));
//     }
//   }

//   Future<void> _onFetchCancell(
//       FetchCancellClasses event, Emitter<ClassesState> emit) async {
//     emit(CompletedClassLoading());

//     try {
//       final classes = await _cancellRepo.Cancellclasses('cancelled');
//       emit(ClassescancellLoaded(classes));
//     } catch (e) {
//       emit(CompletedClassesError(e.toString()));
//     }
//   }

//   Future<void> _onFetchCancellForDate(
//       FetchCancellForDate event, Emitter<ClassesState> emit) async {
//     emit(CompletedClassLoading());

//     try {
//       final dateStr = DateFormat('yyyy-MM-dd').format(event.date);
//       final classes =
//           await _cancellRepo.getClassescancellForDate(dateStr, 'cancelled');
//       emit(ClassescancellLoaded(classes));
//     } catch (e) {
//       emit(CompletedClassesError(e.toString()));
//     }
//   }
// }
// //demolessons

// //lessonsimport 'package:flutter_bloc/flutter_bloc.dart';

// class DemoBloc extends Bloc<ClassesEvent, ClassesState> {
//   final Demorepo _demoRepository;

//   DemoBloc(this._demoRepository) : super(ClassesInitial()) {
//     on<FetchdemoClasses>(_onFetchUpcomingClasses);
//   }
//   Future<void> _onFetchUpcomingClasses(
//       FetchdemoClasses event, Emitter<ClassesState> emit) async {
//     emit(ClassesLoading());

//     try {
//       final responses = await _demoRepository.Completedclasses();
//       emit(DemoLoaded(responses));
//     } catch (e) {
//       emit(ClassesError(e.toString()));
//     }
//   }
// }

// class AllocationsBloc extends Bloc<ClassesEvent, ClassesState> {
//   final Allocationcountrepo _countRepository;

//   AllocationsBloc(this._countRepository) : super(ClassesInitial()) {
//     on<LoadAllocations>(_onFetchStudentCount);
//   }

//   Future<void> _onFetchStudentCount(
//       LoadAllocations event, Emitter<ClassesState> emit) async {
//     emit(ClassesLoading());

//     try {
//       final allocationsData = await _countRepository.getAllocationsData();
//       emit(AllocationsLoaded(allocationsData: allocationsData));
//     } catch (e) {
//       emit(ClassesError(e.toString()));
//     }
//   }
// }

// class UserBloc extends Bloc<ClassesEvent, ClassesState> {
//   final UserRepository userRepository;

//   UserBloc(this.userRepository) : super(ClassesInitial()) {
//     on<LoadUser>(_onLoadUser);
//   }

//   Future<void> _onLoadUser(LoadUser event, Emitter<ClassesState> emit) async {
//     emit(ClassesLoading());

//     try {
//       final user = await userRepository.getUser();
//       emit(UserLoaded(user));
//     } catch (e) {
//       emit(ClassesError(e.toString()));
//     }
//   }
// }