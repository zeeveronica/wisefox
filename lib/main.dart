import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisefox/apps/features/bloc/profile/user_bloc.dart';
import 'package:wisefox/apps/features/bloc/profile/user_bloc.dart';
import 'package:wisefox/client/features/screens/classes.dart';

import 'package:wisefox/student/features/screens/home_page.dart';

import 'package:wisefox/student/features/service/api_service.dart';
import 'apps/utils/screens/commingSoon.dart';
import 'student/features/screens/timer.dart';
import 'apps/login.dart'; // Import your unified login
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:wisefox/apps/features/bloc/auth_bloc.dart' as GeneralAuth;
import 'package:wisefox/apps/features/repos/auth_repos.dart' as GeneralAuthRepo;
import 'package:wisefox/apps/features/bloc/webView/web_view_bloc.dart' as WebViewBloc;
import 'package:wisefox/apps/features/repos/meeting_repos.dart' as MeetingRepo;

import 'package:wisefox/student/features/bloc/auth_bloc.dart' as StudentAuth;
import 'package:wisefox/student/features/bloc/bloc/cancellesson_bloc.dart' as StudentCancelLessonBloc;
import 'package:wisefox/student/features/bloc/demolessons/demo_lessons_bloc.dart' as StudentDemoLessonBloc;
import 'package:wisefox/student/features/bloc/filesharing/filesharing_bloc.dart' as StudentFileSharingBloc;
import 'package:wisefox/student/features/bloc/lessondetails/lessondetails_bloc.dart' as StudentLessonDetailsBloc;
import 'package:wisefox/student/features/bloc/lessons/lesson_bloc.dart' as StudentLessonBloc;
import 'package:wisefox/student/features/bloc/overviewcount/overviewcount_bloc.dart' as StudentOverViewCountBloc;
import 'package:wisefox/student/features/bloc/sendfiles/send_files_bloc.dart' as StudentSendFilesBloc;
import 'package:wisefox/student/features/bloc/sentedfiles/sentedfiles_bloc.dart' as StudentSentedFilesBloc;
import 'package:wisefox/student/features/bloc/students/student_bloc.dart' as StudentBloc;
import 'package:wisefox/student/features/bloc/tutor/tutor_bloc.dart' as StudentTutorBloc;
import 'package:wisefox/student/features/bloc/tutorlist/tutorlist_bloc.dart' as StudentTutorListBloc;
import 'package:wisefox/student/features/model/student_model.dart';
import 'package:wisefox/student/features/repos/auth_repos.dart' as StudentAuthRepo;
import 'package:wisefox/student/features/repos/cancellesson_repos.dart' as StudentCancelLessonRepo;
import 'package:wisefox/student/features/repos/demolesson_repos.dart' as StudentDemoLessonRepo;
import 'package:wisefox/student/features/repos/filesharing_repos.dart' as StudentFileSharingRepo;
import 'package:wisefox/student/features/repos/lesson_repos.dart' as StudentLessonRepo;
import 'package:wisefox/student/features/repos/lessondetails_repos.dart' as StudentLessonDetailsRepo;
import 'package:wisefox/student/features/repos/overview_repos.dart' as StudentOverviewRepo;
import 'package:wisefox/student/features/repos/sendfiles_repos.dart' as StudentSendFilesRepo;
import 'package:wisefox/student/features/repos/sentedfiles_repos.dart' as StudentSentedFilesRepo;
import 'package:wisefox/student/features/repos/student_repos.dart' as StudentRepo;
import 'package:wisefox/student/features/repos/tutor_repos.dart' as StudentTutorRepo;
import 'package:wisefox/student/features/repos/tutorlist_repos.dart' as StudentTutorListRepo;

// Client
import 'package:wisefox/client/features/bloc/bloc/studentlessondetails_bloc.dart' as ClientStuentLessonDetails;
import 'package:wisefox/client/features/bloc/auth_bloc.dart' as ClientAuthBloc;
import 'package:wisefox/client/features/repos/auth_repos.dart' as ClientAuthRepo;
import 'package:wisefox/client/features/bloc/tutor/tutor_bloc.dart' as ClientTutorBloc;
import 'package:wisefox/client/features/repos/tutor_repos.dart' as ClientTutorRepo;
import 'package:wisefox/client/features/bloc/clients/client_bloc.dart' as ClientBloc;
import 'package:wisefox/client/features/repos/Client_repos.dart' as ClientRepo;
import 'package:wisefox/client/features/bloc/clientlesson/clientlesson_bloc.dart' as ClientLessonBloc;
import 'package:wisefox/client/features/repos/clientlesson_repos.dart' as ClientLessonRepo;
import 'package:wisefox/client/features/bloc/studenttutor/studenttutor_bloc.dart' as ClientStudentTutorBloc;
import 'package:wisefox/client/features/bloc/clientdemolesson/clientdemolesson_bloc.dart' as ClientDemoLesson;
import 'package:wisefox/client/features/bloc/isactive/is_active_bloc.dart' as ClientIsActiveBloc;
import 'package:wisefox/client/features/bloc/studenttutorlist/studenttutorlist_bloc.dart' as ClientStudentTutorListBloc;
import 'package:wisefox/client/features/bloc/studentfilesharing/student_filesharing_bloc.dart' as ClientStudentFileSharingBloc;
import 'package:wisefox/client/features/bloc/studentoverview/studentoverviewcount_bloc.dart' as ClientStudentOverViewCount;
import 'package:wisefox/client/features/bloc/studentlesson/studentlesson_bloc.dart' as ClientStudentLessonBloc;
import 'package:wisefox/client/features/bloc/country/country_bloc.dart' as ClientCountryBloc;
import 'package:wisefox/client/features/bloc/student/students_bloc.dart' as ClientStudentBloc;
import 'package:wisefox/client/features/bloc/examboard/examboard_bloc.dart' as ClientExamBoardBloc;
import 'package:wisefox/client/features/bloc/subject/subject_bloc.dart' as ClientSubjectBloc;
import 'package:wisefox/client/features/bloc/studentadmission/studentadmission_bloc.dart' as ClientStudentAdmissionBloc;
import 'package:wisefox/client/features/bloc/studentcount/studentcount_bloc.dart' as ClientStudentCountBloc;
import 'package:wisefox/client/features/bloc/dashboard/dashboard_bloc.dart' as ClientDashboardBloc;
import 'package:wisefox/client/features/bloc/cancellessons/cancellesson_bloc.dart' as ClientCancelLessonBloc;
import 'package:wisefox/client/features/bloc/demolessons/demo_lessons_bloc.dart' as ClientDemoLessonBloc;
import 'package:wisefox/client/features/bloc/filesharing/filesharing_bloc.dart' as ClientFileSharingBloc;
import 'package:wisefox/client/features/bloc/lessondetails/lessondetails_bloc.dart' as ClientLessonDetailsBloc;
import 'package:wisefox/client/features/bloc/clientoverviewcount/clientoverviewcount_bloc.dart' as clientOverViewCountBloc;
import 'package:wisefox/client/features/bloc/sendfiles/send_files_bloc.dart' as ClientSendFilesBloc;
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart' as ClientSentedFilesBlock;
import 'package:wisefox/client/features/bloc/tutorlist/tutorlist_bloc.dart' as ClientTutorListBloc;
import 'package:wisefox/client/features/repos/cancellesson_repos.dart' as ClientCancelLessonRepo;
import 'package:wisefox/client/features/repos/country_repos.dart' as ClientCountryRepo;
import 'package:wisefox/client/features/repos/dashboard_repos.dart' as ClientDashboardRepo;
import 'package:wisefox/client/features/repos/demolesson_repos.dart' as ClientDemoLessonRepos;
import 'package:wisefox/client/features/repos/examboard_repo.dart' as ClientExamBoardRepo;
import 'package:wisefox/client/features/repos/filesharing_repos.dart' as ClientFileSharingRepo;
import 'package:wisefox/client/features/repos/isactive_repos.dart' as ClientIsActiveRepo;
import 'package:wisefox/client/features/repos/lessondetails_repos.dart' as ClientLessonDetailsRepo;
import 'package:wisefox/client/features/repos/clientoverview_repos.dart' as ClientOverviewRepo;
import 'package:wisefox/client/features/repos/selectsubject.dart' as ClientSelectSubject;
import 'package:wisefox/client/features/repos/sendfiles_repos.dart' as ClientSendFilesRepo;
import 'package:wisefox/client/features/repos/demorequest_repos.dart' as ClientDemoRequestRepo;
import 'package:wisefox/client/features/repos/student_repo.dart' as ClientStudentRepo;
import 'package:wisefox/client/features/repos/studentadmissionpost_repos.dart' as ClientStudentAdmissionPostRepo;
import 'package:wisefox/client/features/repos/studentcount_repos.dart' as ClientStudentCountRepo;
import 'package:wisefox/client/features/repos/studentfilerepository.dart' as ClientStudentFilesRepo;
import 'package:wisefox/client/features/repos/studentlessondetails_repos.dart' as ClientStudentLessonDetailsRepo;
import 'package:wisefox/client/features/repos/studentlessonrepository.dart' as ClientStudentLessonRepo;
import 'package:wisefox/client/features/repos/studentoverview_repos.dart' as ClientStudentOverviewRepo;
import 'package:wisefox/client/features/repos/studentreceivedfile_repo.dart' as ClientStudentReceivedFileRepo;
import 'package:wisefox/client/features/repos/studentsendfile_repos.dart' as ClientStudentSendFileRepo;
import 'package:wisefox/client/features/repos/studenttutor_repos.dart' as ClientStudentTutorRepo;
import 'package:wisefox/client/features/repos/studenttutorlist_repos.dart' as ClientStudentTutorListRepo;
import 'package:wisefox/client/features/repos/tutorlist_repos.dart' as ClientTutorListRepo;
import 'package:wisefox/client/features/service/api_service.dart' as ClientApiService;

var h;
var w;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ScreenUtilInit(
    //   designSize: const Size(360, 690), // Your design size
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   builder: (context, child) {
    //     return MaterialApp(
    //       title: 'WiseFox',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home: const AppSelector(),
    //       debugShowCheckedModeBanner: false,
    //     );
    //   },
    // );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            // start
            BlocProvider(
              create: (context) => GeneralAuth.AuthBloc(
                authRepository: GeneralAuthRepo.AuthRepository(),
              )..add(GeneralAuth.CheckLoginStatus()),
            ),
            BlocProvider(
              create: (context) => UserBloc(),
            ),
            BlocProvider(
              create: (context) => WebViewBloc.WebViewBloc(),
              child: ClassesPage()
            ),


        //end


            BlocProvider(create: (context) => StudentTutorBloc.TutorBloc(StudentTutorRepo.TutorRepository())),
            BlocProvider(create: (context) => StudentBloc.StudentBloc(StudentRepo.StudentRepository())),
            BlocProvider(create: (context) => StudentLessonBloc.LessonBloc(StudentLessonRepo.LessonRepository())),
            BlocProvider(
                create: (context) => StudentOverViewCountBloc.OverviewBloc(StudentOverviewRepo.OverviewRepository())),
            BlocProvider(
                create: (context) => StudentFileSharingBloc.FilesharingBloc(StudentFileSharingRepo.FilesharingRepository())),
            BlocProvider(
              create: (context) => StudentDemoLessonBloc.DemoLessonsBloc(StudentDemoLessonRepo.DemoLessonRepository()),
            ),
            BlocProvider(
                create: (context) => StudentTutorListBloc.TutorlistBloc(StudentTutorListRepo.TutorListRepository())),
            BlocProvider(
                create: (context) =>
                    StudentSentedFilesBloc.SentedfilesBloc(StudentSentedFilesRepo.SentFilesRepository(ApiService()))),
            BlocProvider(create: (context) => StudentSendFilesBloc.SendFilesBloc(StudentSendFilesRepo.FileRepository())),
            BlocProvider(
                create: (context) =>
                    StudentLessonDetailsBloc.LessondetailsBloc(StudentLessonDetailsRepo.LessondetailsRepository())),
            BlocProvider(
                create: (context) =>
                    StudentCancelLessonBloc.CancelLessonBloc(StudentCancelLessonRepo.CancelLessonRepository())),

          //   Tutor
          //   BlocProvider(
          //     create: (context) => ClientAuthBloc.AuthBloc(
          //       authRepository: ClientAuthRepo.AuthRepository(httpClient: http.Client()),
          //     )..add(ClientAuthBloc.CheckLoginStatus()),
          //   ),
            BlocProvider(create: (context) => ClientTutorBloc.TutorBloc(ClientTutorRepo.TutorRepository())),
            BlocProvider(create: (context) => ClientBloc.ClientBloc(ClientRepo.ClientRepository())),
            BlocProvider(
                create: (context) =>
                    ClientLessonBloc.ClientLessonBloc(ClientLessonRepo.ClientLessonRepository())),
            BlocProvider(
                create: (context) =>
                    clientOverViewCountBloc.ClientOverviewBloc(ClientOverviewRepo.ClientOverviewRepository())),
            BlocProvider(
                create: (context) => ClientFileSharingBloc.FilesharingBloc(ClientFileSharingRepo.FilesharingRepository())),
            // BlocProvider(
            //   create: (context) => ClientDemoLessonBloc.ClientDemoLessonBloc(StudentDemoLessonRepo()),
            // ),
            BlocProvider(
                create: (context) =>
                    ClientTutorListBloc.AcademicYearBloc(ClientTutorListRepo.AcademicYearRepository())),
            BlocProvider(
                create: (context) =>
                    ClientSentedFilesBlock.DemoRequestBloc(ClientDemoRequestRepo.DemoRequestRepository(ClientApiService.ApiService()))),
            BlocProvider(create: (context) => ClientSendFilesBloc.SendFilesBloc(ClientSendFilesRepo.FileRepository())),
            BlocProvider(
                create: (context) =>
                    ClientLessonDetailsBloc.LessondetailsBloc(ClientLessonDetailsRepo.LessondetailsRepository())),
            BlocProvider(
                create: (context) =>
                    ClientCancelLessonBloc.CancelLessonBloc(ClientCancelLessonRepo.CancelLessonRepository())),
            BlocProvider(
                create: (context) =>
                    ClientDashboardBloc.DashboardBloc(ClientDashboardRepo.DashboardRepository(ClientApiService.ApiService()))),
            BlocProvider(
                create: (context) =>
                    ClientStudentCountBloc.StudentCountBloc(ClientStudentCountRepo.StudentCountRepository())),
            BlocProvider(
              create: (context) =>
                  ClientStudentAdmissionBloc.StudentAdmissionBloc(ClientStudentAdmissionPostRepo.StudentAdmissionRepository()),
            ),
            BlocProvider(
                create: (context) =>
                    ClientSubjectBloc.SubjectBloc(ClientSelectSubject.SubjectRepository(ClientApiService.ApiService()))),
            BlocProvider(
              create: (context) =>
                  ClientExamBoardBloc.ExamBoardBloc(ClientExamBoardRepo.ExamBoardRepository(ClientApiService.ApiService())),
            ),
            BlocProvider(
              create: (context) => ClientCountryBloc.CountryBloc(ClientCountryRepo.CountryRepository(ClientApiService.ApiService())),
            ),
            BlocProvider(
              create: (context) =>
              ClientStudentBloc.StudentBloc(ClientStudentRepo.StudentRepository())..add(ClientStudentBloc.LoadSelectedStudent()),
            ),
            BlocProvider(
                create: (context) =>
                    ClientStudentLessonBloc.StudentLessonBloc(ClientStudentLessonRepo.StudentLessonRepository())),
            BlocProvider(
                create: (context) =>
                    ClientStudentOverViewCount.StudentOverviewCountBloc(ClientStudentOverviewRepo.StudentOverviewRepository())),
            BlocProvider(
                create: (context) =>
                    ClientStudentFileSharingBloc.StudentReceivedFileBloc(ClientStudentReceivedFileRepo.ReceivedFileRepository())),
            BlocProvider(
                create: (context) => ClientStudentFileSharingBloc.StudentSendFileBloc(ClientStudentSendFileRepo.SendFileRepository())),
            BlocProvider(
                create: (context) =>
                    ClientStudentFileSharingBloc.StudentShareFileBloc(ClientStudentFilesRepo.StudentFileRepository())),
            BlocProvider(create: (context) => ClientStudentTutorListBloc.TutorlistBloc(ClientStudentTutorListRepo.Tutorlistrepo())),
            BlocProvider(
                create: (context) => ClientIsActiveBloc.IsActiveBloc(ClientIsActiveRepo.IsActiveRepository())),
            BlocProvider(
                create: (context) =>
                    ClientDemoLesson.ClientDemoLessonBloc(ClientLessonRepo.ClientLessonRepository())),
            BlocProvider(
                create: (context) =>
                    ClientStudentTutorBloc.StudentTutorBloc(ClientStudentTutorRepo.StudentTutorRepository())),
            BlocProvider(
                create: (context) =>
                    ClientStuentLessonDetails.StudentLessonDetailBloc(ClientStudentLessonDetailsRepo.StudentLessonDetailsRepository())),
          ],
          child: MaterialApp(
            title: 'WiseFox',
            theme: ThemeData(
              fontFamily: "Poppins",
              primarySwatch: Colors.blue,
              appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(
                    color: Colors.white),
              )
            ),
            home: const AppSelector(),
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}

class AppSelector extends StatelessWidget {
  const AppSelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize screen dimensions
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    // Option 1: Direct navigation to login

   return const UnifiedLoginPage();
    // return  ComingSoonPage();

    // Option 2: If you want an app selector screen first
    // return _buildAppSelectorScreen(context);
  }
}