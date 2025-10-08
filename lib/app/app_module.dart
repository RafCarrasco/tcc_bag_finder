import 'package:bag_finder/data/datasources/trip_remote_datasource.dart';
import 'package:bag_finder/infra/repositories/trip_repository_impl.dart';
import 'package:bag_finder/shared/providers/traveler_provider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';

// Controllers
import '../features/auth/controller/sign_in_controller.dart';
import '../features/auth/controller/sign_up_controller.dart';
import '../features/auth/controller/auth_controller.dart';
import '../features/collaborator/controllers/landing_page_step_progess.dart';
import '../features/collaborator/controllers/init_user_trip_controller.dart';
import '../features/collaborator/controllers/init_user_trip_dropdown_controller.dart';
import '../features/collaborator/controllers/luggage_quantity_dropdown_controller.dart';
import '../features/admin/controllers/add_collaborator_controler.dart';

//datasource
import 'package:bag_finder/data/datasources/user_remote_datasource.dart';
import 'package:bag_finder/data/datasources/admin_remote_datasource.dart';
import 'package:bag_finder/data/datasources/collaborator_remote_datasource.dart';
import 'package:bag_finder/data/datasources/traveler_remote_datasource.dart';
import 'package:bag_finder/data/datasources/bag_remote_datasource.dart';

//repository
import '../../infra/repositories/user_repository_impl.dart';
import '../../infra/repositories/collaborator_repository_impl.dart';
import '../../infra/repositories/admin_repository_impl.dart';
import '../../infra/repositories/bag_repository_impl.dart';
import '../../infra/repositories/traveler_repository_impl.dart';
import '../../repositories/trip_repository.dart';
import '../../repositories/admin_repository.dart';
import '../../repositories/collaborator_repository.dart';
import '../../repositories/bag_repository.dart';

// Providers
import '../shared/providers/user_provider.dart';
import '../shared/providers/admin_provider.dart';
import '../shared/providers/trip_provider.dart';
import '../shared/providers/collaborator_provider.dart';

// Usecases
import '../features/admin/usecases/update_user_usecase.dart';
import '../features/admin/usecases/delete_user_usecase.dart';
import '../usecase/bag/add_bag_usecase.dart';

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

    //datasource
    i.addLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource());
    i.addLazySingleton<TripRemoteDataSource>(
      () => TripRemoteDataSource(
        travelerRepository: i<TravelerRepositoryImpl>()
      )
      );
    i.addLazySingleton<AdminRemoteDataSource>(() => AdminRemoteDataSource());
    i.addLazySingleton<TravelerRemoteDataSource>(() => TravelerRemoteDataSource());
    i.addLazySingleton<CollaboratorRemoteDataSource>(
      () => CollaboratorRemoteDataSource(
        travelerRepository: i<TravelerRepositoryImpl>(),
      ),
    );
    i.addLazySingleton<BagRemoteDataSource>(() => BagRemoteDataSource());
    
    //repository
    i.addSingleton<Logger>(() => Logger());
    i.addLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl(i()));
    i.addLazySingleton<TripRepositoryImpl>(() => TripRepositoryImpl(i()));
    i.addLazySingleton<ITripRepository>(() => TripRepositoryImpl(i()));
    i.addLazySingleton<IAdminRepository>(() => AdminRepositoryImpl(i()));
    i.addLazySingleton<IBagRepository>(() => BagRepositoryImpl(i()));
    i.addLazySingleton<ICollaboratorRepository>(() => CollaboratorRepositoryImpl(i()));
    i.addLazySingleton<CollaboratorRepositoryImpl>(() => CollaboratorRepositoryImpl(i()));
    i.addLazySingleton<TravelerRepositoryImpl>(() => TravelerRepositoryImpl(i()));

    // Usecases
    i.addLazySingleton<AddBagUsecase>(() => AddBagUsecase(repository: i()));
    i.addLazySingleton<IUpdateUserUsecase>(() => UpdateUserUsecase(repository: i()));
    i.addLazySingleton<IDeleteUserUsecase>(() => DeleteUserUsecase(repository: i()));

    // Provider
    i.addSingleton<UserProvider>(() => UserProvider(i()));
    i.addLazySingleton<AdminProvider>(() => AdminProvider(i()));
    i.addLazySingleton<TravelerProvider>(() => TravelerProvider(i(),i(),i()));
    i.addLazySingleton<TripProvider>(() => TripProvider(i(),i()));
    i.addLazySingleton<CollaboratorProvider>(() => CollaboratorProvider(i()));

    // Controllers
    i.addLazySingleton<SignInController>(() => SignInController());
    i.addLazySingleton<SignUpController>(() => SignUpController());
    i.addLazySingleton<InitUserTripController>(() => InitUserTripController());
    i.addLazySingleton<InitUserTripDropdownController>(() => InitUserTripDropdownController());
    i.addLazySingleton<LuggageQuantityDropdownController>(() => LuggageQuantityDropdownController());
    i.addLazySingleton<AddCollaboratorController>(() => AddCollaboratorController());
    i.addLazySingleton<AuthService>(() => AuthService(i()));
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
      ChildRoute('/profile/', child: (_) => const ProfilePage()),
      ChildRoute('/profile/edit', child: (_) => const EditProfilePage()),
    ]);
  }
}
