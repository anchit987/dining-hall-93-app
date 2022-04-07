import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dining_hall/blocs/cart_bloc/cart_bloc.dart';
import 'package:dining_hall/blocs/cart_product_bloc/cart_product_bloc.dart';
import 'package:dining_hall/blocs/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:dining_hall/blocs/place_order/place_order_cubit.dart';
import 'package:dining_hall/blocs/product_detail_bloc/product_detail_bloc.dart';
import 'package:dining_hall/blocs/sign_up_cubit/sign_up_cubit.dart';
import 'package:dining_hall/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:dining_hall/data/data_sources/firestore_data_source.dart';
import 'package:dining_hall/data/data_sources/product_remote_data_source.dart';
import 'package:dining_hall/data/repositories/cart_repository_impl.dart';
import 'package:dining_hall/data/repositories/product_repository_impl.dart';
import 'package:dining_hall/data/repositories/user_repository_impl.dart';
import 'package:dining_hall/domain/repositories/cart_repository.dart';
import 'package:dining_hall/domain/repositories/product_repository.dart';
import 'package:dining_hall/domain/repositories/user_repository.dart';
import 'package:dining_hall/domain/usecases/auth/forgot_password.dart';
import 'package:dining_hall/domain/usecases/cart/add_item_to_cart.dart';
import 'package:dining_hall/domain/usecases/products/get_all_products.dart';
import 'package:dining_hall/domain/usecases/user_profile/get_user_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/sign_in_cubit/sign_in_cubit.dart';
import '../data/repositories/firebase_auth_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/auth/sign_in_user.dart';
import '../domain/usecases/auth/sign_up_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance
      .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getItInstance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getItInstance
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  //* Repository
  getItInstance.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<UserRespository>(
      () => UserRepositoryImpl(getItInstance(), getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<ProductRespository>(
      () => ProductRepositoryImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<CartRepository>(() => CartRepositoryImpl());

  //* DATASOURCES
  getItInstance.registerLazySingleton<FirestoreDataSource>(
      () => FirestoreDataSourceImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(getItInstance(), getItInstance()));

  //* Usecases
  getItInstance
      .registerLazySingleton<SignInUser>(() => SignInUser(getItInstance()));
  getItInstance
      .registerLazySingleton<SignUpUser>(() => SignUpUser(getItInstance()));
  getItInstance.registerLazySingleton<ForgotPassword>(
      () => ForgotPassword(getItInstance()));
  getItInstance.registerLazySingleton<GetUserDetail>(
      () => GetUserDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetAllProducts>(
      () => GetAllProducts(getItInstance()));
  getItInstance.registerLazySingleton<AddItemToCart>(
      () => AddItemToCart(getItInstance()));

  //* Blocs
  getItInstance.registerFactory<AuthBloc>(() => AuthBloc(getItInstance()));
  getItInstance
      .registerFactory<UserProfileBloc>(() => UserProfileBloc(getItInstance()));
  getItInstance.registerFactory<ProductDetailBloc>(
      () => ProductDetailBloc(getItInstance()));
  getItInstance.registerFactory<CartBloc>(
      () => CartBloc(getItInstance(), getItInstance()));
  getItInstance.registerFactory<CartProductBloc>(
      () => CartProductBloc(getItInstance()));

  //* Cubit
  getItInstance
      .registerFactory<SignUpCubit>(() => SignUpCubit(getItInstance()));
  getItInstance
      .registerFactory<SignInCubit>(() => SignInCubit(getItInstance()));
  getItInstance.registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(getItInstance()));
  getItInstance.registerFactory<PlaceOrderCubit>(
      () => PlaceOrderCubit(getItInstance()));
}
