import 'package:tcc_bag_finder/app/data/datasources/bag_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/collaborator_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/trip_local_datasource.dart';
import 'package:tcc_bag_finder/app/data/datasources/user_local_datasource.dart';
import 'package:tcc_bag_finder/app/presentation/admin/add_collaborator/add_collaborator_page.dart';
import 'package:tcc_bag_finder/app/presentation/admin/add_collaborator/controller/add_collaborator_controller.dart';
import 'package:tcc_bag_finder/app/presentation/admin/collaborator_panel/collaborator_panel_page.dart';
import 'package:tcc_bag_finder/app/presentation/admin/collaborator_panel/widgets/controllers/collaborator_panel_controller.dart';
import 'package:tcc_bag_finder/app/presentation/admin/home/pages/home_admin_page.dart';
import 'package:tcc_bag_finder/app/presentation/admin/stores/admin_provider.dart';
import 'package:tcc_bag_finder/app/presentation/admin/trip_collaborator_panel/collaborator_trips_panel_page.dart';
import 'package:tcc_bag_finder/app/presentation/admin/trip_collaborator_panel/trip_collaborator_panel_page.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/home/home_collaborator_page.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/init_user_trip/controller/init_user_trip_controller.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/init_user_trip/controller/init_user_trip_dropdown_controller.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/init_user_trip/controller/luggage_quantity_dropdown_controller.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/init_user_trip/init_user_trip_page.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/landing_collaborator_page.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/search_company_trip/search_company_trip_page.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/stores/collaborator_provider.dart';
import 'package:tcc_bag_finder/app/presentation/collaborator/stores/trip_provider.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/pages/home_traveler_page.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/home/pages/traveler_bag_history_page.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/landing_traveler_page.dart';
import 'package:tcc_bag_finder/app/presentation/traveler/stores/traveler_provider.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/controller/sign_in_controller.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/controller/sign_up_controller.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/pages/login_landing_page.dart';
import 'package:tcc_bag_finder/app/presentation/admin/landing_admin_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/landing/controller/landing_page_step_progess.dart';
import 'package:tcc_bag_finder/app/presentation/user/landing/pages/splash_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/landing/pages/welcome_landing_page.dart';
import 'package:tcc_bag_finder/app/presentation/profile/controller/update_controller.dart';
import 'package:tcc_bag_finder/app/presentation/profile/landing_profile_page.dart';
import 'package:tcc_bag_finder/app/presentation/profile/pages/edit_profile_page.dart';
import 'package:tcc_bag_finder/app/presentation/profile/pages/profile_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/pages/landing/contact_us_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/pages/landing/find_your_account_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/pages/landing/forgot_password_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/pages/sign_in_page.dart';
import 'package:tcc_bag_finder/app/presentation/user/auth/pages/sign_up_page.dart';
import 'package:tcc_bag_finder/app/shared/helpers/environments/environment_config.dart';
import 'package:tcc_bag_finder/app/presentation/user/stores/user_provider.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/bag_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/collaborator_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/trip_hive_service.dart';
import 'package:tcc_bag_finder/app/shared/services/hive/user_hive_service.dart';
import 'package:tcc_bag_finder/domain/repositories/bag_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/collaborator_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/traveler_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/trip_repository.dart';
import 'package:tcc_bag_finder/domain/repositories/user_repository.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/add_bag_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/get_bag_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/get_user_active_bags_by_id_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/get_current_trip_bags_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/bag/update_bag_usecacse.dart';
import 'package:tcc_bag_finder/domain/usecases/collaborator/get_collaborators_by_responsible_id_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/traveler/get_all_traveler_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/add_trip_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/check_done_trip_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_all_trip_by_company_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_all_trip_by_traveler_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_trips_by_id_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/get_trips_by_status_and_id_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/trip/update_trip_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/add_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/delete_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/edit_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/get_all_users_by_ids_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/get_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/get_users_by_name_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/login_user_usecase.dart';
import 'package:tcc_bag_finder/domain/usecases/user/update_user_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:logger/logger.dart';
import 'package:event_bus/event_bus.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ILoginUserUsecase>(
      LoginUserUsecase.new,
    );
    i.addLazySingleton<IAddUserUsecase>(
      AddUserUsecase.new,
    );

    i.addLazySingleton<IGetAllUsersByIdsUsecase>(
      GetAllUsersByIdsUsecase.new,
    );

    i.addLazySingleton<IGetUserUsecase>(
      GetUserUsecase.new,
    );
    i.addLazySingleton<IUpdateUserUsecase>(
      UpdateUserUsecase.new,
    );

    i.addLazySingleton<IDeleteUserUsecase>(
      DeleteUserUsecase.new,
    );

    i.addLazySingleton<Logger>(
      Logger.new,
    );

    i.addLazySingleton<EventBus>(
      EventBus.new,
    );

    i.addSingleton<IUserRepository>(
      () => EnvironmentConfig.getUserRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<LandingPageStepProgess>(
      LandingPageStepProgess.new,
    );

    i.addLazySingleton<UserProvider>(
      UserProvider.new,
    );

    i.addLazySingleton<SignInController>(
      SignInController.new,
    );

    i.addLazySingleton<SignUpController>(
      SignUpController.new,
    );

    i.addLazySingleton<UpdateController>(
      UpdateController.new,
    );

    i.addLazySingleton<BagHiveLocalDatasource>(
      BagHiveLocalDatasource.new,
    );

    i.addLazySingleton<CollaboratorHiveLocalDatasource>(
      CollaboratorHiveLocalDatasource.new,
    );

    i.addLazySingleton<UserHiveLocalDatasource>(
      UserHiveLocalDatasource.new,
    );

    i.addLazySingleton<IUserLocalDatasource>(
      () => EnvironmentConfig.getUserLocalDatasource(),
    );

    i.addLazySingleton<IBagLocalDatasource>(
      () => EnvironmentConfig.getBagLocalDatasource(),
    );

    i.addLazySingleton<ITripLocalDatasource>(
      () => EnvironmentConfig.getTripLocalDatasource(),
    );

    i.addLazySingleton<ICollaboratorLocalDatasource>(
      () => EnvironmentConfig.getCollaboratorLocalDatasource(),
    );
  }

  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const SplashPage(),
      transition: TransitionType.leftToRight,
    );

    r.child(
      '/welcome',
      child: (context) => const WelcomeLandingPage(),
      transition: TransitionType.leftToRight,
    );

    r.module(
      '/traveler',
      module: TravelerModule(),
      transition: TransitionType.leftToRight,
    );

    r.module(
      '/admin',
      module: AdminModule(),
      transition: TransitionType.leftToRight,
    );

    r.module(
      '/login',
      module: AuthModule(),
      transition: TransitionType.leftToRight,
    );

    r.module(
      '/profile',
      module: ProfileModule(),
      transition: TransitionType.leftToRight,
    );

    r.module(
      '/collaborator',
      module: CollaboratorModule(),
    );
  }
}

class AuthModule extends Module {
  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const LoginLandingPage(),
      children: [
        ChildRoute(
          '/sign-in',
          child: (context) {
            return const SignInPage();
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/sign-up',
          child: (context) {
            return const SignUpPage();
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/contact-us',
          child: (context) => const ContactUsPage(),
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/forgot-password',
          child: (context) => const ForgotPasswordPage(),
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/find-your-account',
          child: (context) => const FindYourAccountPage(),
          transition: TransitionType.leftToRight,
        ),
      ],
    );
  }
}

class TravelerModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AdminProvider>(
      AdminProvider.new,
    );

    i.addLazySingleton<TravelerProvider>(
      TravelerProvider.new,
    );

    i.addLazySingleton<IGetUserActiveBagsByIdUsecase>(
      GetUserActiveBagsByIdUsecase.new,
    );

    i.addLazySingleton<IGetCurrentTripBagsByIdUsecase>(
      GetCurrentTripBagsByIdUsecase.new,
    );

    i.addLazySingleton<IGetAllTripsByTravelerIdUsecase>(
      GetAllTripsByTravelerIdUsecase.new,
    );

    i.addLazySingleton<IUpdateBagUsecase>(
      UpdateBagUsecase.new,
    );

    i.addLazySingleton<IGetTripsByIdUsecase>(
      GetTripsByIdUsecase.new,
    );

    i.addLazySingleton<ICheckDoneTripUsecase>(
      CheckDoneTripUsecase.new,
    );

    i.addLazySingleton<IUpdateTripUsecase>(
      UpdateTripUsecase.new,
    );

    i.addLazySingleton<IGetBagsByIdUsecase>(
      GetBagsByIdUsecase.new,
    );

    i.addLazySingleton<IGetTripsByStatusAndIdUsecase>(
      GetTripsByStatusAndIdUsecase.new,
    );

    i.addLazySingleton<IBagRepository>(
      () => EnvironmentConfig.getBagRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<ITripRepository>(
      () => EnvironmentConfig.getTripRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<IBagLocalDatasource>(
      BagHiveLocalDatasource.new,
    );

    i.addLazySingleton<ITripLocalDatasource>(
      TripHiveLocalDatasource.new,
    );

    i.addLazySingleton<IUserLocalDatasource>(
      UserHiveLocalDatasource.new,
    );
  }

  @override
  void routes(r) {
    r.child(
      '/:travelerId',
      child: (context) => LandingTravelerPage(
        travelerId: r.args.params['travelerId'],
      ),
      children: [
        ChildRoute(
          '/home',
          child: (context) {
            return HomeTravelerPage(
              travelerId: r.args.params['travelerId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/history-panel',
          child: (context) {
            return TravelerBagHistoryPage(
              travelerId: r.args.params['travelerId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/profile',
          child: (context) {
            return const ProfilePage();
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/profile/edit',
          child: (context) {
            return const EditProfilePage();
          },
          transition: TransitionType.leftToRight,
        ),
      ],
    );
  }
}

class CollaboratorModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<CollaboratorProvider>(
      CollaboratorProvider.new,
    );

    i.addLazySingleton<EventBus>(
      EventBus.new,
    );

    i.addLazySingleton<TripProvider>(
      TripProvider.new,
    );

    i.addLazySingleton<AdminProvider>(
      AdminProvider.new,
    );

    i.addLazySingleton<IAddTripUsecase>(
      AddTripUsecase.new,
    );

    i.addLazySingleton<IAddBagUsecase>(
      AddBagUsecase.new,
    );

    i.addLazySingleton<IGetAllTravelerUsecase>(
      GetTravelerUsecase.new,
    );

    i.addLazySingleton<IGetAllTripsByResponsibleIdUsecase>(
      GetAllTripsByResponsibleIdUsecase.new,
    );

    i.addLazySingleton<IGetUsersByNameUsecase>(
      GetUsersByNameUsecase.new,
    );

    i.addLazySingleton<IGetCollaboratorsByResponsibleIdUsecase>(
      GetCollaboratorsByResponsibleIdUsecase.new,
    );

    i.addLazySingleton<IGetAllTripsByTravelerIdUsecase>(
      GetAllTripsByTravelerIdUsecase.new,
    );

    i.addSingleton<IBagRepository>(
      () => EnvironmentConfig.getBagRepository(),
      config: BindConfig(),
    );

    i.addSingleton<ITravelerRepository>(
      () => EnvironmentConfig.getTravelerRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<ICollaboratorRepository>(
      () => EnvironmentConfig.getCollaboratorRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<ITripRepository>(
      () => EnvironmentConfig.getTripRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<InitUserTripDropdownController>(
      InitUserTripDropdownController.new,
    );

    i.addLazySingleton<InitUserTripController>(
      InitUserTripController.new,
    );

    i.addLazySingleton<CollaboratorPanelController>(
      CollaboratorPanelController.new,
    );

    i.addLazySingleton<LuggageQuantityDropdownController>(
      LuggageQuantityDropdownController.new,
    );

    i.addLazySingleton<IBagLocalDatasource>(
      BagHiveLocalDatasource.new,
    );

    i.addLazySingleton<ITripLocalDatasource>(
      TripHiveLocalDatasource.new,
    );

    i.addLazySingleton<IUserLocalDatasource>(
      UserHiveLocalDatasource.new,
    );
  }

  @override
  void routes(r) {
    r.child(
      '/:collaboratorId',
      child: (context) => LandingCollaboratorPage(
        collaboratorId: r.args.params['collaboratorId'],
      ),
      children: [
        ChildRoute(
          '/home',
          child: (context) {
            return const HomeCollaboratorPage();
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/init-user-trip',
          child: (context) {
            return const InitUserTripPage();
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/search-company-trips',
          child: (context) {
            return SearchCompanyTripPage(
              collaboratorId: r.args.params['collaboratorId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
      ],
    );
  }
}

class ProfileModule extends Module {
  @override
  void routes(r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const LandingProfilePage(),
      children: [
        ChildRoute(
          '/:userId',
          child: (context) => const ProfilePage(),
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/edit',
          child: (context) => const EditProfilePage(),
          transition: TransitionType.leftToRight,
        ),
      ],
    );
  }
}

class AdminModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<AdminProvider>(
      AdminProvider.new,
    );

    i.addLazySingleton<IGetAllTripsByResponsibleIdUsecase>(
      GetAllTripsByResponsibleIdUsecase.new,
    );

    i.addLazySingleton<ICollaboratorRepository>(
      () => EnvironmentConfig.getCollaboratorRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<IDeleteUserUsecase>(
      DeleteUserUsecase.new,
    );

    i.addLazySingleton<IUpdateUserUsecase>(
      UpdateUserUsecase.new,
    );

    i.addLazySingleton<IGetUsersByNameUsecase>(
      GetUsersByNameUsecase.new,
    );

    i.addLazySingleton<IEditUserUsecase>(
      EditUserUsecase.new,
    );

    i.addLazySingleton<IGetCollaboratorsByResponsibleIdUsecase>(
      GetCollaboratorsByResponsibleIdUsecase.new,
    );

    i.addSingleton<IUserRepository>(
      () => EnvironmentConfig.getUserRepository(),
      config: BindConfig(),
    );

    i.addSingleton<ITripRepository>(
      () => EnvironmentConfig.getTripRepository(),
      config: BindConfig(),
    );

    i.addLazySingleton<AddCollaboratorController>(
      AddCollaboratorController.new,
    );

    i.addLazySingleton<IBagLocalDatasource>(
      BagHiveLocalDatasource.new,
    );

    i.addLazySingleton<ITripLocalDatasource>(
      TripHiveLocalDatasource.new,
    );

    i.addLazySingleton<IUserLocalDatasource>(
      UserHiveLocalDatasource.new,
    );
  }

  @override
  void routes(r) {
    r.child(
      '/:adminId',
      child: (context) => LandingAdminPage(
        adminId: r.args.params['adminId'],
      ),
      children: [
        ChildRoute(
          '/home',
          child: (context) {
            return HomeAdminPage(
              adminId: r.args.params['adminId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/collaborator-panel',
          child: (context) {
            return CollaboratorPanelPage(
              adminId: r.args.params['adminId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/trip-collaborator-panel',
          child: (context) {
            return TripCollaboratorPanelPage(
              adminId: r.args.params['adminId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/trip-collaborator-panel/:collaboratorId',
          child: (context) {
            return CollaboratorTripsPanelPage(
              collaboratorId: r.args.params['collaboratorId'],
            );
          },
          transition: TransitionType.leftToRight,
        ),
        ChildRoute(
          '/add-collaborator',
          child: (context) {
            return const AddCollaboratorPage();
          },
          transition: TransitionType.leftToRight,
        )
      ],
    );
  }
}
