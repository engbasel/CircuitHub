// import 'package:get_it/get_it.dart';
// import 'package:store/Core/Services/data_service.dart';
// import 'package:store/Core/Services/firebase_auth_service.dart';
// import 'package:store/Core/Services/firestor_service.dart';
// import 'package:store/Featuers/auth/data/repos/auth_repo_impl.dart';
// import 'package:store/Featuers/auth/domain/repos/auth_repo.dart';

// final getIt = GetIt.instance;

// void setupGetit() {
//   getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
//   getIt.registerSingleton<DatabaseService>(FirestorService());

//   getIt.registerSingleton<AuthRepo>(
//     AuthRepoImpl(
//       firebaseAuthService: getIt<FirebaseAuthService>(),
//       databaseService: getIt<DatabaseService>(),
//     ),
//   );
// }
