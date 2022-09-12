import 'package:equatable/equatable.dart';

class SliderPageObject {
  final String title;
  final String subTitle;
  final String image;

  SliderPageObject(this.title, this.subTitle, this.image);
}

class SliderPageViewObject {
  SliderPageObject sliderPageObject;
  int numberOfPages;
  int currentPageIndex;

  SliderPageViewObject(
      this.sliderPageObject, this.numberOfPages, this.currentPageIndex);
}

class User extends Equatable{
  final String id;

    final  int numberOfNotifications;

  final String name;

 const  User({
    required this.id,
    required this.numberOfNotifications,
    required this.name,
  });

  static const   User  empty =   User(id: '',numberOfNotifications: 0,name: '');

  @override
  List<Object?> get props => [id,name,numberOfNotifications];

}

class Contact {
  String phone;

  String address;

  String link;

  Contact({
    required this.phone,
    required this.address,
    required this.link,
  });
}

class Authentication {
  final User? user;
  final String accessToken;
  Authentication({
    required this.user,
    required this.accessToken,
  });
}


class ForgetPassword{

  String? support;

  ForgetPassword({
    required  this.support,
  });
}

class Service {
  int id;
  String title;
  String image;

  Service({
    required this.id,
    required this.title,
    required this.image,
  });
}

class BannerAd {
  int id;
  String title;
  String image;

  BannerAd({
    required this.id,
    required this.title,
    required this.image,
  });
}


class Store {
  int id;
  String title;
  String image;

  Store({
    required this.id,
    required this.title,
    required this.image,
  });
}


class HomeData {
  List<Service> services;

  List<BannerAd> banners;

  List<Store> stores;

  HomeData({
   required this.services,
    required this.banners,
   required this.stores,
  });
}

class HomeObject {
   HomeData? data;

   HomeObject({
    this.data,
  });
}


class StoreDetails {
  String image;

  int id;

  String title;

  String details;

  String service;

  StoreDetails(
      this.image, this.id, this.title, this.details, this.service, this.about);

  String about;

}


