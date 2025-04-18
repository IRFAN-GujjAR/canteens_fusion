final class UserTypeConstants {
  static const none = "none";
  static const customer = "customer";
  static const owner = "owner";
}

enum UserType { none, customer, owner }

const Map<UserType, String> userTypes = {
  UserType.none: UserTypeConstants.none,
  UserType.owner: UserTypeConstants.owner,
  UserType.customer: UserTypeConstants.customer
};

const Map<String, UserType> userTypesStoE = {
  UserTypeConstants.none: UserType.none,
  UserTypeConstants.owner: UserType.owner,
  UserTypeConstants.customer: UserType.customer
};

extension UserTypeExtensions on UserType {
  bool get isCustomer => this == UserType.customer;
  bool get isOwner => this == UserType.owner;
  UserType get reverseUserType =>
      isCustomer ? UserType.owner : UserType.customer;
}
