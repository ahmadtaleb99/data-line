import 'package:form_builder_test/data/responses/responses.dart';
import 'package:form_builder_test/data/responses/responses.dart';
import 'package:form_builder_test/domain/model/models.dart';
import 'package:form_builder_test/app/extenstions.dart';
import 'package:form_builder_test/domain/model/text_field_model/text_field_model.dart';

import '../responses/forms/forms_response.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        id: this?.id.orEmpty() ?? '',
        numberOfNotifications: this?.numberOfNotifications.orZero() ?? 0,
        name: this?.name.orEmpty() ?? '');
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
        address: this?.address.orEmpty() ?? '',
        phone: this?.phone.orEmpty() ?? '',
        link: this?.link.orEmpty() ?? '');
  }
}

extension AuthenticationMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
        customer: this?.customerResponse.toDomain(),
        contact: this?.contactResponse.toDomain());
  }
}

extension ForgetPasswordMapper on ForgetPasswordResponse? {
  ForgetPassword toDomain() {
    return ForgetPassword(support: this?.support.orEmpty() ?? '');
  }

}

extension ServiceMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
        id: this?.id ?? 0 ,

        title: this?.title.orEmpty() ?? '',
        image: this?.image.orEmpty() ?? '');
  }
}

extension BannerMapper on BannerResponse? {
  BannerAd toDomain() {
    return BannerAd(
        id: this?.id ?? 0 ,

        title: this?.title.orEmpty() ?? '',
        image: this?.image.orEmpty() ?? '');
  }
}

extension StoreMapper on StoreResponse? {
  Store toDomain() {
    return Store(
        id: this?.id ?? 0 ,
        title: this?.title.orEmpty() ?? '',
        image: this?.image.orEmpty() ?? '');
  }
}

extension HomeObjectMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services =
        this?.homeDataResponse.services?.map((e) => e.toDomain()).toList() ?? [];
    List<BannerAd> banners =
        this?.homeDataResponse.banners?.map((e) => e.toDomain()).toList() ?? [];
    List<Store> stores =
        this?.homeDataResponse.stores?.map((e) => e.toDomain()).toList() ?? [];

    HomeData data = HomeData(services :services, banners : banners, stores : stores);

    return HomeObject(data:  data);
  }
}

extension StoreDetailsMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(this?.image.orEmpty() ?? '',
        this?.id.orZero() ?? 0, this?.title.orEmpty() ?? '',
        this?.details.orEmpty() ?? '',
        this?.service.orEmpty() ?? '',
        this?.about.orEmpty() ?? '');
  }
}

