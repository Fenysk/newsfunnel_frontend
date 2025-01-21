import 'package:get_it/get_it.dart';
import 'package:newsfunnel_frontend/features/auth/3_presentation/bloc/auth.cubit.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/repository/mails.repository-impl.dart';
import 'package:newsfunnel_frontend/features/mails/1_data/source/mails-api.service.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/repository/mails.repository.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/unlink-mail-server.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/delete-mail.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/generate-summary.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/get-mail-details.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/get-mails-from-address.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/get-user-mail-servers.usecase.dart';
import 'package:newsfunnel_frontend/features/mails/2_domain/usecase/mark-mail-read-state.usecase.dart';
import 'package:newsfunnel_frontend/features/user/1_data/repository/users.repository-impl.dart';
import 'package:newsfunnel_frontend/features/user/1_data/source/user-local.service.dart';
import 'package:newsfunnel_frontend/features/user/1_data/source/users-api.service.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/repository/users.repository.dart';
import 'package:newsfunnel_frontend/core/network/dio_client.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/repository/auth.repository-impl.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/source/auth-api.service.dart';
import 'package:newsfunnel_frontend/features/auth/1_data/source/auth-local.service.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/repository/auth.repository.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/usecase/get-my-profile.usecase.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/is_loggin_in.usercase.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/login.usecase.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/logout.usecase.dart';
import 'package:newsfunnel_frontend/features/auth/2_domain/usecase/register.usecase.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/usecase/get-user-profile.usecase.dart';
import 'package:newsfunnel_frontend/features/user/2_domain/usecase/load-my-user-profile.usecase.dart';
import 'package:newsfunnel_frontend/template/1_data/repository/exemple.repository-impl.dart';
import 'package:newsfunnel_frontend/template/1_data/source/exemple-api.service.dart';
import 'package:newsfunnel_frontend/template/1_data/source/exemple-local.service.dart';
import 'package:newsfunnel_frontend/template/2_domain/repository/exemple.repository.dart';
import 'package:newsfunnel_frontend/template/2_domain/usecase/get-exemple.usecase.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //// Template
  serviceLocator.registerSingleton<ExempleApiService>(ExempleApiServiceImpl());
  serviceLocator.registerSingleton<ExempleLocalService>(ExempleLocalServiceImpl());
  serviceLocator.registerSingleton<ExempleRepository>(ExempleRepositoryImpl());
  serviceLocator.registerSingleton<GetExempleUsecase>(GetExempleUsecase());

  //// Cubit
  serviceLocator.registerSingleton(() => AuthCubit());

  //// Network
  serviceLocator.registerSingleton<DioClient>(DioClient());

  //// Services
  serviceLocator.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  serviceLocator.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  serviceLocator.registerSingleton<UsersApiService>(UsersApiServiceImpl());
  serviceLocator.registerSingleton<UserLocalService>(UserLocalServiceImpl());
  serviceLocator.registerSingleton<MailsApiService>(MailsApiServiceImpl());

  //// Repositories
  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  serviceLocator.registerSingleton<UsersRepository>(UsersRepositoryImpl());
  serviceLocator.registerSingleton<MailsRepository>(MailsRepositoryImpl());

  //// Usecases
  serviceLocator.registerSingleton<RegisterUsecase>(RegisterUsecase());
  serviceLocator.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  serviceLocator.registerSingleton<GetMyProfileUsecase>(GetMyProfileUsecase());
  serviceLocator.registerSingleton<GetUserProfileUsecase>(GetUserProfileUsecase());
  serviceLocator.registerSingleton<LoadMyUserProfileUsecase>(LoadMyUserProfileUsecase());
  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase());
  serviceLocator.registerSingleton<LoginUsecase>(LoginUsecase());
  serviceLocator.registerSingleton<GetUserMailServersUsecase>(GetUserMailServersUsecase());
  serviceLocator.registerSingleton<GetMailsFromAddressUsecase>(GetMailsFromAddressUsecase());
  serviceLocator.registerSingleton<GetMailDetailsUsecase>(GetMailDetailsUsecase());
  serviceLocator.registerSingleton<DeleteMailUsecase>(DeleteMailUsecase());
  serviceLocator.registerSingleton<MarkMailReadStateUsecase>(MarkMailReadStateUsecase());
  serviceLocator.registerSingleton<GenerateSummaryUsecase>(GenerateSummaryUsecase());
  serviceLocator.registerSingleton<UnlinkMailServerUsecase>(UnlinkMailServerUsecase());
}
