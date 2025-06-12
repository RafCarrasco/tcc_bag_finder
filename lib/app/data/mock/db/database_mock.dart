import 'package:tcc_bag_finder/domain/entity/admin_entity.dart';
import 'package:tcc_bag_finder/domain/entity/bag_entity.dart';
import 'package:tcc_bag_finder/domain/entity/collaborator_entity.dart';
import 'package:tcc_bag_finder/domain/entity/traveler_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_description_entity.dart';
import 'package:tcc_bag_finder/domain/entity/trip_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_avatar_entity.dart';
import 'package:tcc_bag_finder/domain/entity/user_entity.dart';
import 'package:tcc_bag_finder/domain/enums/user_role_enum.dart';
import 'package:tcc_bag_finder/domain/enums/bag_status_enum.dart';
import 'package:uuid/uuid.dart';

class MockDatabase {
  final List<UserEntity> users;
  final List<BagEntity> bags;
  final List<TripEntity> trips;

  MockDatabase()
      : users = [],
        trips = [],
        bags = [] {
    AdminEntity admin = AdminEntity(
      email: 'admin@example.com',
      password: 'admin',
      fullName: 'Admin',
      dateOfBirth: '',
      phone: '(11) 99999-9999',
      avatar: UserAvatarEntity.empty(),
      role: UserRoleEnum.ADMIN,
      updatedAt: null,
      createdAt: DateTime.now(),
      company: 'LATAM',
    );

    CollaboratorEntity specialCollaborator = CollaboratorEntity(
      fullName: 'Yuji Miguel Arima',
      dateOfBirth: '',
      email: 'yujiarima@example.com',
      avatar: UserAvatarEntity.empty(),
      password: 'yujiarima',
      isActive: true,
      responsibleId: admin.id,
      company: 'LATAM',
      tripsCreated: 4,
      phone: '1111111111',
    );

    TravelerEntity specialTraveler = TravelerEntity(
      phone: '(11) 99999-9999',
      email: 'traveler@gmail.com',
      password: 't',
      fullName: 'Traveler Admin',
      dateOfBirth: '',
      avatar: UserAvatarEntity.empty(),
      updatedAt: null,
    );

    TravelerEntity secondSpecialTraveler = TravelerEntity(
      phone: '(11) 99999-9999',
      email: 'traveler2@gmail.com',
      password: 'traveler2',
      fullName: 'Traveler Admin 2',
      dateOfBirth: '',
      avatar: UserAvatarEntity.empty(),
      updatedAt: null,
    );

    users.add(
      admin,
    );

    users.add(
      specialCollaborator,
    );

    users.add(
      specialTraveler,
    );

    users.addAll([
      CollaboratorEntity(
        fullName: 'Ana Silva',
        email: 'collaborator@example.com',
        avatar: UserAvatarEntity.empty(),
        dateOfBirth: '',
        password: 'collaborator',
        isActive: true,
        responsibleId: admin.id,
        company: 'LATAM',
        phone: '1111111111',
      ),
      CollaboratorEntity(
        fullName: 'Carlos Gomes',
        email: 'carlos.gomes@example.com',
        avatar: UserAvatarEntity.empty(),
        dateOfBirth: '',
        password: '12345',
        isActive: true,
        responsibleId: admin.id,
        company: 'LATAM',
        phone: '1111111111',
      ),
      CollaboratorEntity(
        fullName: 'Fernanda Oliveira',
        email: 'fernanda.oliveira@example.com',
        avatar: UserAvatarEntity.empty(),
        dateOfBirth: '',
        password: '12345',
        isActive: true,
        responsibleId: admin.id,
        company: 'LATAM',
        phone: '1111111111',
      ),
      CollaboratorEntity(
        fullName: 'Roberto Souza',
        email: 'roberto.souza@example.com',
        avatar: UserAvatarEntity.empty(),
        dateOfBirth: '',
        password: '12345',
        isActive: true,
        responsibleId: admin.id,
        company: 'LATAM',
        phone: '1111111111',
      ),
      CollaboratorEntity(
        fullName: 'Luciana Martins',
        email: 'luciana.martins@example.com',
        avatar: UserAvatarEntity.empty(),
        dateOfBirth: '',
        password: '12345',
        isActive: true,
        responsibleId: admin.id,
        company: 'LATAM',
        phone: '1111111111',
      ),
    ]);

    users.addAll([
      TravelerEntity(
        phone: '(11) 99999-9999',
        email: 'traveler@gmail.com',
        password: 'traveler',
        fullName: 'Traveler Admin',
        dateOfBirth: '',
        avatar: UserAvatarEntity.empty(),
        updatedAt: null,
      ),
      TravelerEntity(
        phone: '(11) 99999-9999',
        email: 'traveler1@gmail.com',
        password: 'traveler',
        fullName: 'Traveler 1',
        dateOfBirth: '',
        avatar: UserAvatarEntity.empty(),
        updatedAt: null,
      ),
      TravelerEntity(
        phone: '(11) 99999-9999',
        email: 'traveler2@gmail.com',
        password: 'traveler',
        fullName: 'Traveler 2',
        dateOfBirth: '',
        avatar: UserAvatarEntity.empty(),
        updatedAt: null,
      ),
    ]);

    bags.addAll([
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Mala grande azul com rodinhas",
        status: BagStatusEnum.ARRIVED,
        updatedAt: DateTime(
          2024,
          10,
          12,
          12,
          0,
          0,
        ),
      ),
      BagEntity(
          ownerId: const Uuid().v4(),
          description: "Mala pequena preta",
          status: BagStatusEnum.ARRIVED,
          updatedAt: DateTime.now()),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Mochila de viagem verde",
        status: BagStatusEnum.ARRIVED,
        updatedAt: DateTime(
          2023,
          9,
          11,
          11,
          0,
          0,
        ),
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Bolsa de couro marrom",
        status: BagStatusEnum.ARRIVED,
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Mala média vermelha com adesivos",
        status: BagStatusEnum.CHECKED_IN,
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Maleta de mão preta",
        status: BagStatusEnum.CHECKED_IN,
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Mala grande com estampa floral",
        status: BagStatusEnum.CHECKED_IN,
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Mochila esportiva cinza",
        status: BagStatusEnum.CHECKED_IN,
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Saco de viagem azul-marinho",
        status: BagStatusEnum.CHECKED_IN,
      ),
      BagEntity(
        ownerId: const Uuid().v4(),
        description: "Bolsa preta com compartimento extra",
        status: BagStatusEnum.CHECKED_IN,
      ),
    ]);

    trips.addAll([
      TripEntity(
        responsibleCollaboratorId: specialCollaborator.id,
        description: TripDescriptionEntity(
          airportOrigin: 'GR-Sao Paulo',
          airportDestination: 'SP-Sao Paulo',
        ),
        isDone: false,
        bags: [bags[0], bags[1], bags[2]],
        travelerEntity: specialTraveler,
        time: DateTime.now(),
      ),
      TripEntity(
        responsibleCollaboratorId: specialCollaborator.id,
        description: TripDescriptionEntity(
          airportOrigin: 'GR-Sao Paulo',
          airportDestination: 'SP-Sao Paulo',
        ),
        isDone: true,
        bags: [bags[0], bags[1], bags[2]],
        travelerEntity: specialTraveler,
        time: DateTime.now(),
        updatedAt: DateTime(
          2024,
          10,
          12,
          12,
          0,
          0,
        ),
      ),
      TripEntity(
        responsibleCollaboratorId: specialCollaborator.id,
        description: TripDescriptionEntity(
          airportOrigin: 'FR - Paris',
          airportDestination: 'US - New York',
        ),
        isDone: true,
        bags: [
          bags[0],
        ],
        travelerEntity: specialTraveler,
        time: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      TripEntity(
        responsibleCollaboratorId: specialCollaborator.id,
        description: TripDescriptionEntity(
          airportOrigin: 'França - São Paulo',
          airportDestination: 'França - Rio de Janeiro',
        ),
        isDone: true,
        bags: [
          bags[0],
          bags[1],
          bags[2],
        ],
        travelerEntity: secondSpecialTraveler,
        time: DateTime.now(),
      )
    ]);
  }
}
