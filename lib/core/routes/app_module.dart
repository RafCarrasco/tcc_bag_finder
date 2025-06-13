import 'package:event_bus/event_bus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Controllers
import '../../controller/auth/sign_in_controller.dart';
import '../../controller/auth/sign_up_controller.dart';
import '../../controller/landing_page_step_progess.dart';

// Providers
import '../../repositories/user_repository.dart';
import '../infra/user_repository_impl.dart';
import '../provider/user_provider.dart';

// Usecases
import '../../usecase/update_user_usecase.dart';
import '../../usecase/delete_user_usecase.dart';

// Pages
import '../../pages/landing/splash_page.dart';
import '../../pages/landing/landign_page.dart';
import '../../pages/sign/login_landing_page.dart';
import '../../pages/sign/sign_in_page.dart';
import '../../pages/sign/sign_up_page.dart';
import '../../pages/sign/forgot_password_page.dart';
import '../../pages/sign/find_your_account_page.dart';
import '../../pages/admin/landing_admin_page.dart';
import '../../pages/admin/home_admin_page.dart';
import '../../pages/admin/add_collaborator_page.dart';
import '../../pages/colaborator/collaborator_panel_page.dart';
import '../../pages/colaborator/trip_collaborator_panel_page.dart';
import '../../pages/colaborator/collaborator_trips_panel_page.dart';
import '../../pages/colaborator/landing_collaborator_page.dart';
import '../../pages/colaborator/home_collaborator_page.dart';
import '../../pages/colaborator/init_user_trip_page.dart';
import '../../pages/colaborator/search_company_trip_page.dart';
import '../../pages/traveler/landing_traveler_page.dart';
import '../../pages/traveler/home_traveler_page.dart';
import '../../pages/traveler/traveler_bag_history_page.dart';
import '../../pages/traveler/profile_page.dart';
import '../../pages/traveler/edit_profile_page.dart';


class AppModule extends Module {
  @override
  void binds(Injector i) {
    // EventBus
    i.addSingleton<EventBus>(() => EventBus());

    // Firebase
    i.addSingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    i.addSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

    // Repositório
    i.addLazySingleton<IUserRepository>(() => UserRepositoryImpl(firestore: i()));

    // Usecases
    i.addLazySingleton<IUpdateUserUsecase>(() => UpdateUserUsecase(repository: i()));
    i.addLazySingleton<IDeleteUserUsecase>(() => DeleteUserUsecase(repository: i()));

    // Provider
    i.addLazySingleton<UserProvider>(() => UserProvider(i(), i()));

    // Controllers
    i.addLazySingleton<SignInController>(() => SignInController(i(), i()));
    i.addLazySingleton<SignUpController>(() => SignUpController(i(), i()));
    i.addLazySingleton<LandingPageStepProgess>(LandingPageStepProgess.new);
  }

  @override
  void routes(RouteManager r) {
    // Splash & Welcome
    r.child(Modular.initialRoute, child: (_) => const SplashPage());
    r.child('/welcome', child: (_) => const WelcomeLandingPage());

    // Login / Auth
    r.child('/login', child: (_) => const LoginLandingPage(), children: [
      ChildRoute('/sign-in', child: (_) => const SignInPage()),
      ChildRoute('/sign-up', child: (_) => const SignUpPage()),
      ChildRoute('/forgot-password', child: (_) => const ForgotPasswordPage()),
      ChildRoute('/find-your-account', child: (_) => const FindYourAccountPage()),
    ]);

    // Admin
    r.child('/admin/:adminId', child: (_) {
      final id = r.args.params['adminId'];
      return LandingAdminPage(adminId: id);
    }, children: [
      ChildRoute('/home', child: (_) => HomeAdminPage(adminId: r.args.params['adminId'])),
      ChildRoute('/add-collaborator', child: (_) => const AddCollaboratorPage()),
      ChildRoute('/collaborator-panel', child: (_) => CollaboratorPanelPage(adminId: r.args.params['adminId'])),
      ChildRoute('/trip-collaborator-panel', child: (_) => TripCollaboratorPanelPage(adminId: r.args.params['adminId'])),
      ChildRoute('/trip-collaborator-panel/:collaboratorId', child: (_) => CollaboratorTripsPanelPage(collaboratorId: r.args.params['collaboratorId'])),
    ]);

    // Collaborator
    r.child('/collaborator/:collaboratorId', child: (_) {
      final id = r.args.params['collaboratorId'];
      return LandingCollaboratorPage(collaboratorId: id);
    }, children: [
      ChildRoute('/home', child: (_) => const HomeCollaboratorPage()),
      ChildRoute('/init-user-trip', child: (_) => const InitUserTripPage()),
      ChildRoute('/search-company-trips', child: (_) => SearchCompanyTripPage(collaboratorId: r.args.params['collaboratorId'])),
    ]);

    // Traveler
    r.child('/traveler/:travelerId', child: (_) {
      final id = r.args.params['travelerId'];
      return LandingTravelerPage(travelerId: id);
    }, children: [
      ChildRoute('/home', child: (_) => HomeTravelerPage(travelerId: r.args.params['travelerId'])),
      ChildRoute('/history-panel', child: (_) => TravelerBagHistoryPage(travelerId: r.args.params['travelerId'])),
      ChildRoute('/profile', child: (_) => const ProfilePage()),
      ChildRoute('/profile/edit', child: (_) => const EditProfilePage()),
    ]);
  }
}
