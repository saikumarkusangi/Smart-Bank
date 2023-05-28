class PeopleModel {
  var userImg;
  var userName;

  PeopleModel(this.userImg, this.userName);
}

class BusinessTypeModel {
  var businessImg;
  var businessName;

  BusinessTypeModel(this.businessImg, this.businessName);
}

class ContactModel {
  var userImg;
  var userName;
  var userPhoneNumber;

  ContactModel(this.userImg, this.userName, this.userPhoneNumber);
}

class DthModel {
  var dthImg;
  var dthName;

  DthModel(this.dthImg, this.dthName);
}

class DthDetailsModel {
  var img;
  var name;
  var title;

  DthDetailsModel(this.img, this.name, this.title);
}

class RechargeModel {
  var img;
  var name;

  RechargeModel(this.img, this.name);
}

class RechargeForYouModel {
  var rechargeAmount;
  var offer;

  RechargeForYouModel(this.rechargeAmount, this.offer);
}

class RechargeDataModel {
  var rechargeAmount;
  var validity;
  var offers;

  RechargeDataModel(this.rechargeAmount, this.validity, this.offers);
}

class TopUpRechargeModel {
  var amount;
  var validity;
  var offer;

  TopUpRechargeModel(this.amount, this.validity, this.offer);
}

class PopularBusinessModel {
  var image;
  var title;
  var offer;

  PopularBusinessModel(this.image, this.title, this.offer);
}

class BusinessSublistModel {
  var image;
  var name;
  var description;
  var buttonTitle;

  BusinessSublistModel(this.image, this.name, this.description, this.buttonTitle);
}

class RewardAmountModel {
  String? rewardAmount;
  var description;
  bool isScratch;

  RewardAmountModel({this.rewardAmount, this.description, this.isScratch = false});
}

class OfferModel {
  var img;
  var earnAmount;
  var description;

  OfferModel(this.img, this.earnAmount, this.description);
}

class AllTransactionsModel {
  var img;
  var name;
  var date;
  var amount;

  AllTransactionsModel(this.img, this.name, this.date, this.amount);
}

class ChatModel {
  var name;
  var img;
  var lastMsg;
  var time;
  int? unreadCount;
  var phoneNumber;
  bool? isActive;

  ChatModel({this.name, this.img, this.lastMsg, this.time, this.unreadCount, this.phoneNumber, this.isActive});
}

class MessageModel {
  int? senderId;
  int? receiverId;
  String? msg;
  String? time;

  MessageModel({this.senderId, this.receiverId, this.msg, this.time});
}
