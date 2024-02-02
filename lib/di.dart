
import 'package:dio/dio.dart';
import 'package:ushopie_ecom/features/auth/data/repo/signin_repo.dart';
import 'package:ushopie_ecom/features/auth/data/repo/signup_repo.dart';
import 'package:ushopie_ecom/features/auth/data/source/remote.dart';
import 'package:ushopie_ecom/features/auth/domain/repo/signin_repo.dart';
import 'package:ushopie_ecom/features/auth/domain/repo/signup_repo.dart';
import 'package:ushopie_ecom/features/auth/domain/usecase/signin_usecase.dart';
import 'package:ushopie_ecom/features/auth/domain/usecase/signup_usecase.dart';
import 'package:ushopie_ecom/features/cart/data/repo/cart_repo_impl.dart';
import 'package:ushopie_ecom/features/cart/data/source/remote.dart';
import 'package:ushopie_ecom/features/cart/domain/repo/cart_repo.dart';
import 'package:ushopie_ecom/features/cart/domain/usecases/cart_usecase.dart';
import 'package:ushopie_ecom/features/feedback/data/repo/contact_us_repo_impl.dart';
import 'package:ushopie_ecom/features/feedback/data/source/remote.dart';
import 'package:ushopie_ecom/features/feedback/domain/repo/contact_us_repo.dart';
import 'package:ushopie_ecom/features/feedback/domain/usecases/contact_us_usecase.dart';
import 'package:ushopie_ecom/features/products/data/repo/products_repo.dart';
import 'package:ushopie_ecom/features/products/data/source/remote.dart';
import 'package:ushopie_ecom/features/products/domain/repo/products_repo.dart';
import 'package:ushopie_ecom/features/products/domain/usecases/products_usecase.dart';
import 'package:ushopie_ecom/features/wishlist/data/remote/wishlistRemote.dart';
import 'package:ushopie_ecom/features/wishlist/data/repo/getWishlistRepoImpl.dart';
import 'package:ushopie_ecom/features/wishlist/domain/repo/getWishlistRepo.dart';
import 'package:ushopie_ecom/features/wishlist/domain/usecase/wishlist_usecase.dart';

class DependancyInjection {

  static Dio _createDio () {
    return Dio();
  }

  // Remote Source

  static RemoteSource _createRemoteSource() {
    // Create the remote data source
    return RemoteSource(dio: _createDio());
  }

  static RemoteSourceProduct _createRemoteProduct() {
    return RemoteSourceProduct(dio: _createDio());
  }

  static RemoteCartSource _createRemoteCart() {
    return RemoteCartSource(dio: _createDio());
  }

  static ContactUsRemote _createContactRemote() {
    return ContactUsRemote(dio: _createDio());
  }
  
  static WishlistRemote _createWishlistRemote() {
    return WishlistRemote(dio: _createDio());
  }
  // Repo:

  static SignupRepo _createSignupRepo() {
    // Create the repository
    return SignupRepoImpl(remoteSource: _createRemoteSource());
  }

  
  static SigninRepo _createSigninRepo() {
    return SigninRepoImpl(remoteSource: _createRemoteSource());
  }

  static ProductsRepo _createProductRepo() {
    return ProductsRepoImpl(remoteProduct: _createRemoteProduct());
  }

  static CartRepo _createCartRepo () {
    return CartRepoImpl(cartSource: _createRemoteCart());
  }

  static ContactUsRepo _createContactRepo () {
    return ContactUsRepoImpl(remote: _createContactRemote());
  }

  static GetWishlistRepo _createWishlistRepo () {
    return GetWishListRepoImpl(remote: _createWishlistRemote());
  }

  // Use cases:

  static SignupUsecase createSignupUsecase() {
    // Create the use case
    return SignupUsecase(signupRepo: _createSignupRepo());
  }

  static SigninUsecase createLoginUsecase() {
    return SigninUsecase(signinRepo: _createSigninRepo());
  }

  static ProductUsecase createProductUsecase() {
    return ProductUsecase(productsRepo: _createProductRepo());
  }

  static CartUsecase createCartUsecase() {
    return CartUsecase(cartRepo: _createCartRepo());
  }

  static ContactUsUsecase createContactUsUsecase() {
    return ContactUsUsecase(contactUsRepo: _createContactRepo());
  }

  static WishlistUsecase createWishlistUsecase() {
    return WishlistUsecase(repo: _createWishlistRepo());
  }
}