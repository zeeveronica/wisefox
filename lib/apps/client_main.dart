//
// // Client App
// import 'package:wisefox/client/features/bloc/auth_bloc.dart';
// import 'package:wisefox/client/features/bloc/bloc/studentlessondetails_bloc.dart';
// import 'package:wisefox/client/features/bloc/studenttutor/studenttutor_bloc.dart';
// import 'package:wisefox/client/features/bloc/clientdemolesson/clientdemolesson_bloc.dart';
// import 'package:wisefox/client/features/bloc/isactive/is_active_bloc.dart';
// import 'package:wisefox/client/features/bloc/studenttutorlist/studenttutorlist_bloc.dart';
// import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_bloc.dart';
// import 'package:wisefox/client/features/bloc/studentoverview/studentoverviewcount_bloc.dart';
// import 'package:wisefox/client/features/bloc/studentlesson/studentlesson_bloc.dart';
// import 'package:wisefox/client/features/bloc/country/country_bloc.dart';
// import 'package:wisefox/client/features/bloc/student/students_bloc.dart';
// import 'package:wisefox/client/features/bloc/examboard/examboard_bloc.dart';
// import 'package:wisefox/client/features/bloc/clients/client_bloc.dart';
// import 'package:wisefox/client/features/bloc/subject/subject_bloc.dart';
// import 'package:wisefox/client/features/bloc/studentadmission/studentadmission_bloc.dart';
// import 'package:wisefox/client/features/bloc/studentcount/studentcount_bloc.dart';
// import 'package:wisefox/client/features/bloc/dashboard/dashboard_bloc.dart';
// import 'package:wisefox/client/features/bloc/cancellessons/cancellesson_bloc.dart';
// import 'package:wisefox/client/features/bloc/demolessons/demo_lessons_bloc.dart';
// import 'package:wisefox/client/features/bloc/filesharing/filesharing_bloc.dart';
// import 'package:wisefox/client/features/bloc/lessondetails/lessondetails_bloc.dart';
// import 'package:wisefox/client/features/bloc/clientlesson/clientlesson_bloc.dart';
// import 'package:wisefox/client/features/bloc/clientoverviewcount/clientoverviewcount_bloc.dart';
// import 'package:wisefox/client/features/bloc/sendfiles/send_files_bloc.dart';
// import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
// import 'package:wisefox/client/features/bloc/tutor/tutor_bloc.dart';
// import 'package:wisefox/client/features/bloc/tutorlist/tutorlist_bloc.dart';
// import 'package:wisefox/client/features/repos/Client_repos.dart';
// import 'package:wisefox/client/features/repos/auth_repos.dart';
// import 'package:wisefox/client/features/repos/cancellesson_repos.dart';
// import 'package:wisefox/client/features/repos/country_repos.dart';
// import 'package:wisefox/client/features/repos/dashboard_repos.dart';
// import 'package:wisefox/client/features/repos/demolesson_repos.dart';
// import 'package:wisefox/client/features/repos/examboard_repo.dart';
// import 'package:wisefox/client/features/repos/filesharing_repos.dart';
// import 'package:wisefox/client/features/repos/clientlesson_repos.dart';
// import 'package:wisefox/client/features/repos/isactive_repos.dart';
// import 'package:wisefox/client/features/repos/lessondetails_repos.dart';
// import 'package:wisefox/client/features/repos/clientoverview_repos.dart';
// import 'package:wisefox/client/features/repos/selectsubject.dart';
// import 'package:wisefox/client/features/repos/sendfiles_repos.dart';
// import 'package:wisefox/client/features/repos/demorequest_repos.dart';
// import 'package:wisefox/client/features/repos/student_repo.dart';
// import 'package:wisefox/client/features/repos/studentadmissionpost_repos.dart';
// import 'package:wisefox/client/features/repos/studentcount_repos.dart';
// import 'package:wisefox/client/features/repos/studentfilerepository.dart';
// import 'package:wisefox/client/features/repos/studentlessondetails_repos.dart';
// import 'package:wisefox/client/features/repos/studentlessonrepository.dart';
// import 'package:wisefox/client/features/repos/studentoverview_repos.dart';
// import 'package:wisefox/client/features/repos/studentreceivedfile_repo.dart';
// import 'package:wisefox/client/features/repos/studentsendfile_repos.dart';
// import 'package:wisefox/client/features/repos/studenttutor_repos.dart';
// import 'package:wisefox/client/features/repos/studenttutorlist_repos.dart';
// import 'package:wisefox/client/features/repos/tutor_repos.dart';
// import 'package:wisefox/client/features/repos/tutorlist_repos.dart';
// import 'package:wisefox/client/features/screens/bottom_nav.dart';
// import 'package:wisefox/client/features/screens/getstart_page.dart';
// import 'package:wisefox/client/features/screens/login_page.dart';
// import 'package:wisefox/client/features/screens/splashscreen.dart';
// import 'package:wisefox/client/features/service/api_service.dart';
// import 'package:wisefox/client/features/service/shared_preferences.dart';
// import 'package:wisefox/client/features/utils/thecolors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:wisefox/main.dart';
//
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized(); // Ensure async initialization
// //   final isFirstLaunch = await SharedPreferencesHelper.isFirstLaunch();
// //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
// //       .then((_) {
// //     runApp(MyApp(isFirstLaunch: isFirstLaunch));
// //   });
// // }
//
// class ClientApp extends StatelessWidget {
//   final bool isFirstLaunch;
//
//   const ClientApp({super.key, required this.isFirstLaunch});
//
//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height;
//     w = MediaQuery.of(context).size.width;
//     return ScreenUtilInit(
//       designSize: Size(360, 690),
//       builder: (context, child) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider(
//               create: (context) => AuthBloc(
//                 authRepository: AuthRepository(httpClient: http.Client()),
//               )..add(CheckLoginStatus()),
//             ),
//             BlocProvider(create: (context) => TutorBloc(TutorRepository())),
//             BlocProvider(create: (context) => ClientBloc(ClientRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     ClientLessonBloc(ClientLessonRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     ClientOverviewBloc(ClientOverviewRepository())),
//             BlocProvider(
//                 create: (context) => FilesharingBloc(FilesharingRepository())),
//             BlocProvider(
//               create: (context) => DemoLessonsBloc(DemoLessonRepository()),
//             ),
//             BlocProvider(
//                 create: (context) =>
//                     AcademicYearBloc(AcademicYearRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     DemoRequestBloc(DemoRequestRepository(ApiService()))),
//             BlocProvider(create: (context) => SendFilesBloc(FileRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     LessondetailsBloc(LessondetailsRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     CancelLessonBloc(CancelLessonRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     DashboardBloc(DashboardRepository(ApiService()))),
//             BlocProvider(
//                 create: (context) =>
//                     StudentCountBloc(StudentCountRepository())),
//             BlocProvider(
//               create: (context) =>
//                   StudentAdmissionBloc(StudentAdmissionRepository()),
//             ),
//             BlocProvider(
//                 create: (context) =>
//                     SubjectBloc(SubjectRepository(ApiService()))),
//             BlocProvider(
//               create: (context) =>
//                   ExamBoardBloc(ExamBoardRepository(ApiService())),
//             ),
//             BlocProvider(
//               create: (context) => CountryBloc(CountryRepository(ApiService())),
//             ),
//             BlocProvider(
//               create: (context) =>
//               StudentBloc(StudentRepository())..add(LoadSelectedStudent()),
//             ),
//             BlocProvider(
//                 create: (context) =>
//                     StudentLessonBloc(StudentLessonRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     StudentOverviewCountBloc(StudentOverviewRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     StudentReceivedFileBloc(ReceivedFileRepository())),
//             BlocProvider(
//                 create: (context) => StudentSendFileBloc(SendFileRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     StudentShareFileBloc(StudentFileRepository())),
//             BlocProvider(create: (context) => TutorlistBloc(Tutorlistrepo())),
//             BlocProvider(
//                 create: (context) => IsActiveBloc(IsActiveRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     ClientDemoLessonBloc(ClientLessonRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     StudentTutorBloc(StudentTutorRepository())),
//             BlocProvider(
//                 create: (context) =>
//                     StudentLessonDetailBloc(StudentLessonDetailsRepository())),
//           ],
//           child: BlocBuilder<AuthBloc, AuthState>(
//             builder: (context, state) {
//               return GestureDetector(
//                 onTap: () {
//                   FocusManager.instance.primaryFocus!.unfocus();
//                 },
//                 child: MaterialApp(
//                   routes: {
//                     '/login': (context) => Bottomnav(),
//                   },
//                   theme: ThemeData(
//                     scaffoldBackgroundColor: Colors.white,
//                     snackBarTheme: SnackBarThemeData(
//                       backgroundColor: theColors.bottomnavColor,
//                       contentTextStyle: TextStyle(color: Colors.white),
//                     ),
//                     textButtonTheme: TextButtonThemeData(
//                       style: ButtonStyle(
//                         textStyle: MaterialStateProperty.all(
//                           TextStyle(fontSize: 45.sp),
//                         ),
//                       ),
//                     ),
//                     textTheme: GoogleFonts.poppinsTextTheme(
//                       Theme.of(context).textTheme.apply(
//                         bodyColor: Colors.black,
//                         displayColor: Colors.black,
//                       ),
//                     ),
//                   ),
//                   debugShowCheckedModeBanner: false,
//                   home: isFirstLaunch
//                       ? GetstartPage()
//                       : (state is PrepSuccess ? Bottomnav() : LoginPage()),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }