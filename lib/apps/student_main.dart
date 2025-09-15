//Student App
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:wisefox/apps/utils/thecolors.dart';
import 'package:wisefox/main.dart';
import 'package:wisefox/student/features/bloc/auth_bloc.dart';
import 'package:wisefox/student/features/bloc/bloc/cancellesson_bloc.dart';
import 'package:wisefox/student/features/bloc/lessondetails/lessondetails_bloc.dart';
import 'package:wisefox/student/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/student/features/bloc/demolessons/demo_lessons_bloc.dart';

import 'package:wisefox/student/features/bloc/filesharing/filesharing_bloc.dart';
import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart';
import 'package:wisefox/student/features/bloc/overviewcount/overviewcount_bloc.dart';
import 'package:wisefox/student/features/bloc/sendfiles/send_files_bloc.dart';
import 'package:wisefox/student/features/bloc/students/student_bloc.dart';
import 'package:wisefox/student/features/bloc/tutor/tutor_bloc.dart';
import 'package:wisefox/student/features/bloc/tutorlist/tutorlist_bloc.dart';
import 'package:wisefox/student/features/repos/auth_repos.dart';
import 'package:wisefox/student/features/repos/cancellesson_repos.dart';
import 'package:wisefox/student/features/repos/demolesson_repos.dart';
import 'package:wisefox/student/features/repos/filesharing_repos.dart';
import 'package:wisefox/student/features/repos/lesson_repos.dart';
import 'package:wisefox/student/features/repos/lessondetails_repos.dart';
import 'package:wisefox/student/features/repos/overview_repos.dart';
import 'package:wisefox/student/features/repos/sendfiles_repos.dart';
import 'package:wisefox/student/features/repos/sentedfiles_repos.dart';
import 'package:wisefox/student/features/repos/student_repos.dart';
import 'package:wisefox/student/features/repos/tutor_repos.dart';
import 'package:wisefox/student/features/repos/tutorlist_repos.dart';
import 'package:wisefox/student/features/screens/bottom_nav.dart';
import 'package:wisefox/student/features/screens/getstart_page.dart';
import 'package:wisefox/student/features/screens/login_page.dart';
import 'package:wisefox/student/features/service/api_service.dart';
import 'package:wisefox/student/features/service/shared_preferences.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensure async initialization
//   final isFirstLaunch = await SharedPreferencesHelper.isFirstLaunch();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp(MyApp(isFirstLaunch: isFirstLaunch));
//   });
// }

class StudentApp extends StatelessWidget {
  final bool isFirstLaunch;

  const StudentApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: AuthRepository(httpClient: http.Client()),
              )..add(CheckLoginStatus()),
            ),
            BlocProvider(create: (context) => TutorBloc(TutorRepository())),
            BlocProvider(create: (context) => StudentBloc(StudentRepository())),
            BlocProvider(create: (context) => LessonBloc(LessonRepository())),
            BlocProvider(
                create: (context) => OverviewBloc(OverviewRepository())),
            BlocProvider(
                create: (context) => FilesharingBloc(FilesharingRepository())),
            BlocProvider(
              create: (context) => DemoLessonsBloc(DemoLessonRepository()),
            ),
            BlocProvider(
                create: (context) => TutorlistBloc(TutorListRepository())),
            BlocProvider(
                create: (context) =>
                    SentedfilesBloc(SentFilesRepository(ApiService()))),
            BlocProvider(create: (context) => SendFilesBloc(FileRepository())),
            BlocProvider(
                create: (context) =>
                    LessondetailsBloc(LessondetailsRepository())),
            BlocProvider(
                create: (context) =>
                    CancelLessonBloc(CancelLessonRepository())),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                child: MaterialApp(
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                    snackBarTheme: SnackBarThemeData(
                      backgroundColor: theColors.bottomnavColor,
                      contentTextStyle: TextStyle(color: Colors.white),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          TextStyle(fontSize: 45.sp),
                        ),
                      ),
                    ),
                    textTheme: GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme.apply(
                        bodyColor: Colors.black,
                        displayColor: Colors.black,
                      ),
                    ),
                  ),
                  debugShowCheckedModeBanner: false,
                  home: isFirstLaunch
                      ? GetstartPage()
                      : (state is PrepSuccess ? Bottomnav() : LoginPage()),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
