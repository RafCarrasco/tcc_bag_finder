import 'package:event_bus/event_bus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/web.dart';

// Controllers
import '../features/auth/controller/sign_in_controller.dart';
import '../features/auth/controller/sign_up_controller.dart';
import '../features/collaborator/controllers/landing_page_step_progess.dart';

// Providers
import '../infra/repositories/user_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../shared/providers/user_provider.dart';

// Datasources
import '../data/datasources/user_remote_datasource.dart';

// Usecases
import '../features/admin/usecases/update_user_usecase.dart';
import '../features/admin/usecases/delete_user_usecase.dart';

// Pages
import '../features/trip/pages/splash_page.dart';
import '../pages/landing/landign_page.dart';
import '../features/auth/pages/login_landing_page.dart';
import '../features/auth/pages/sign_in_page.dart';
import '../features/auth/pages/sign_up_page.dart';
import '../features/auth/pages/forgot_password_page.dart';
import '../features/auth/pages/find_your_account_page.dart';
import '../features/admin/pages/landing_admin_page.dart';
import '../features/admin/pages/home_admin_page.dart';
import '../features/admin/pages/add_collaborator_page.dart';
import '../features/collaborator/pages/collaborator_panel_page.dart';
import '../features/collaborator/pages/trip_collaborator_panel_page.dart';
import '../features/collaborator/pages/collaborator_trips_panel_page.dart';
import '../features/collaborator/pages/landing_collaborator_page.dart';
import '../features/collaborator/pages/home_collaborator_page.dart';
import '../features/collaborator/pages/init_user_trip_page.dart';
import '../features/collaborator/pages/search_company_trip_page.dart';
import '../features/traveler/pages/landing_traveler_page.dart';
import '../features/traveler/pages/home_traveler_page.dart';
import '../features/traveler/pages/traveler_bag_history_page.dart';
import '../features/traveler/pages/profile_page.dart';
import '../features/traveler/pages/edit_profile_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    // EventBus
    i.addSingleton<EventBus>(() => EventBus());

    // Logger
    i.addLazySingleton<Logger>(() => Logger());

    // Datasource real (Node + MySQL)
    i.addLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(baseUrl: "http://localhost:3000"),
    );

    // Repositório real (usa o datasource)
    i.addLazySingleton<IUserRepository>(
      () => UserRepositoryImpl(i()),
    );
    i.addLazySingleton<UserRepositoryImpl>(
    () => UserRepositoryImpl(i()),
  );

    // Usecases
    i.addLazySingleton<IUpdateUserUsecase>(
      () => UpdateUserUsecase(repository: i()),
    );
    i.addLazySingleton<IDeleteUserUsecase>(
      () => DeleteUserUsecase(repository: i()),
    );

    // Provider
    i.addLazySingleton<UserProvider>(
      () => UserProvider(i()),
    );

    // Controllers
    i.addLazySingleton<SignInController>(
      () => SignInController(),
    );
    i.addLazySingleton<SignUpController>(
      () => SignUpController(),
    );

    i.addLazySingleton<LandingPageStepProgess>(
      () => LandingPageStepProgess(),
    );
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
      ChildRoute('/find-your-account',
          child: (_) => const FindYourAccountPage()),
    ]);

    // Admin
    r.child('/admin/:adminId', child: (_) {
      final id = r.args.params['adminId'];
      return LandingAdminPage(adminId: id);
    }, children: [
      ChildRoute('/home',
          child: (_) => HomeAdminPage(adminId: r.args.params['adminId'])),
      ChildRoute('/add-collaborator',
          child: (_) => const AddCollaboratorPage()),
      ChildRoute('/collaborator-panel',
          child: (_) =>
              CollaboratorPanelPage(adminId: r.args.params['adminId'])),
      ChildRoute('/trip-collaborator-panel',
          child: (_) =>
              TripCollaboratorPanelPage(adminId: r.args.params['adminId'])),
      ChildRoute('/trip-collaborator-panel/:collaboratorId',
          child: (_) => CollaboratorTripsPanelPage(
              collaboratorId: r.args.params['collaboratorId'])),
    ]);

    // Collaborator
    r.child('/collaborator/:collaboratorId', child: (_) {
      final id = r.args.params['collaboratorId'];
      return LandingCollaboratorPage(collaboratorId: id);
    }, children: [
      ChildRoute('/home', child: (_) => const HomeCollaboratorPage()),
      ChildRoute('/init-user-trip', child: (_) => const InitUserTripPage()),
      ChildRoute('/search-company-trips',
          child: (_) => SearchCompanyTripPage(
              collaboratorId: r.args.params['collaboratorId'])),
    ]);

    // Traveler
    r.child('/traveler/:travelerId', child: (_) {
      final id = r.args.params['travelerId'];
      return LandingTravelerPage(travelerId: id);
    }, children: [
      ChildRoute('/home',
          child: (_) =>
              HomeTravelerPage(travelerId: r.args.params['travelerId'])),
      ChildRoute('/history-panel',
          child: (_) =>
              TravelerBagHistoryPage(travelerId: r.args.params['travelerId'])),
      ChildRoute('/profile', child: (_) => const ProfilePage()),
      ChildRoute('/profile/edit', child: (_) => const EditProfilePage()),
    ]);
  }
}
