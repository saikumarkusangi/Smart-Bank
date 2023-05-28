import 'dart:math';
import 'package:bank/components/components.dart';
import 'package:bank/controllers/controllers.dart';
import 'package:bank/models/smartbank_model.dart';
import 'package:bank/utils/String.dart';
import 'package:bank/utils/images.dart';
import 'package:bank/views/features/send/to_person.dart';
import 'package:bank/views/features/transactions/transcations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../views/widgets/widgets.dart';

const senderid = 1;
const receiverid = 2;

List<PeopleModel> getPeopleData() {
  List<PeopleModel> mList = [];

  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Lia Smith"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Lia Smith"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Jerry"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Nora Joe"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Antonio"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Elvina"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Emma"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Benjamin"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Lia"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "Isabella"));
  mList.add(PeopleModel("images/cloneApp//user0.jpeg", "William"));

  return mList;
}

List<BusinessTypeModel> getBusinessTypeData() {
  List<BusinessTypeModel> mList = [];
  mList.add(BusinessTypeModel(const Icon(Icons.flight), "Ticket Booking"));
  mList.add(BusinessTypeModel(const Icon(Icons.bar_chart), "Stocks & IPO"));
  mList.add(BusinessTypeModel(const Icon(Icons.home), "Insurance"));
  mList.add(BusinessTypeModel(const Icon(Icons.local_hospital), "Health"));
  mList.add(BusinessTypeModel(const Icon(Icons.card_travel), "Travel"));

  return mList;
}

List<PeopleModel> getBusinessData() {
  List<PeopleModel> mList = [];

  mList.add(PeopleModel(flight, "Flight Tickets".tr));
  mList.add(PeopleModel(bus, "Bus Tickets".tr));
  mList.add(PeopleModel(train, "Train \nTickets"));
  mList.add(PeopleModel(movie, "Movie \nTickets"));
  mList.add(PeopleModel(event, "Event Tickets"));
  mList.add(PeopleModel(hotel, "Hotels"));
  mList.add(PeopleModel(toll, "Toll"));
  mList.add(PeopleModel(uber, "uber \ncabs"));

  return mList;
}

List<PeopleModel> getPromotionsData() {
  List<PeopleModel> mList = [];

  mList.add(PeopleModel(reward, "Rewards"));
  mList.add(PeopleModel(offer, "Offers"));
  mList.add(PeopleModel(referrals, "Referrals"));

  return mList;
}

List<DthDetailsModel> getPlayStoreData() {
  List<DthDetailsModel> mList = [];

  mList.add(DthDetailsModel(img1, "EP Store Recharge Code", "Bill pments"));

  return mList;
}

List<PopularBusinessModel> getPopularBusinessModel() {
  List<PopularBusinessModel> mList = [];
  mList.add(PopularBusinessModel(
      resortimg,
      'Popular! Get 8 % off MakeMyTrip flights',
      "Save up to \u20B9 on your flight"));
  mList.add(PopularBusinessModel(
      redbustravel,
      'Save up to \u20B9300 on your 1s Redbus ticket',
      "Use code FIRST, now till Nov 30"));
  mList.add(PopularBusinessModel(giftimg, 'Get 20% off your first Dunzo order',
      "Sace up to \u20B9 100, now till Dec 31"));
  return mList;
}

List<BusinessSublistModel> getBusinessTravelList() {
  List<BusinessSublistModel> mList = [];
  mList
      .add(BusinessSublistModel(bus, "Buses", "Travel in Buses", "Book Buses"));
  mList.add(
      BusinessSublistModel(train, "Trains", "Travel in Train", "Book Train"));
  return mList;
}

List<PopularBusinessModel> getFoodBusinessModel() {
  List<PopularBusinessModel> mList = [];
  mList.add(PopularBusinessModel(zomatobanner, '', ""));
  mList.add(PopularBusinessModel(swiggybanner, '', ""));
  return mList;
}

List<BusinessSublistModel> getBusinessFoodList() {
  List<BusinessSublistModel> mList = [];
  mList.add(BusinessSublistModel(
      ubereats, "Uber Eats", "Tasty food delivered to you ", "Order food"));
  mList.add(BusinessSublistModel(
      medicines, "Apollo", "Order your Medecines", "Order \nmedecines"));
  return mList;
}

List<RewardAmountModel> getRewardAmount() {
  List<RewardAmountModel> mList = [];
  mList.add(RewardAmountModel(rewardAmount: "10", description: "You won"));
  mList.add(RewardAmountModel(rewardAmount: "5", description: "You won"));
  mList.add(
      RewardAmountModel(rewardAmount: "Better Luck", description: "next time"));
  mList.add(
      RewardAmountModel(rewardAmount: "Better Luck", description: "next time"));
  mList.add(RewardAmountModel(rewardAmount: "10", description: "You won"));
  mList.add(RewardAmountModel(rewardAmount: "5", description: "You won"));
  mList.add(RewardAmountModel(rewardAmount: "20", description: "You won"));
  mList.add(RewardAmountModel(rewardAmount: "16", description: "You won"));
  mList.add(
      RewardAmountModel(rewardAmount: "Better Luck", description: "next time"));
  mList.add(RewardAmountModel(rewardAmount: "5", description: "You won"));

  return mList;
}

List<OfferModel> getOfferData() {
  List<OfferModel> mList = [];
  mList.add(OfferModel(playstoreoffer, "Earn up to \u20B9150",
      "On your first ever transactions of \u20B930 + on the $PSAppName"));
  mList.add(OfferModel(youtubeoffer, "Get up to \20B9399 on Youtube Premium",
      "Use Rp Bank to buy YouTube Premium 3-month plan and get up to  \u20B9399 as cashback"));
  mList.add(OfferModel(
      electricityoffer,
      "Get \u20B920 to \u20B92000 on electricity bill p..",
      "Make your 1st and 2st electricity bill pments ofe \u20B9"));
  mList.add(OfferModel(visaoffer, "Get up to \20B9399 on Visa Premium",
      "On your first ever transactions of \u20B930 + on the Visa"));

  return mList;
}

List sendMoney = [
  ['Bank \nTransfer', benktransfer, const BankTransferComponent()],
  ['Send to person', person,  ToPerson()],
  ['Transcation \nHistory', paymentactivityimg, const Transactions()],
  [
    'Account \nBalance',
    walletimg,
    PinVerifyScreen(
      auth: true,
      page: 'balance',
    )
  ]
];

List explore = [
  ['Ticket Booking',Icons.flight],
  ['Stocks & IPO', Icons.bar_chart],
  ['Insurance', Icons.home],
  ['Health', Icons.medical_services],
];

List promotions = [
  ['Rewards', reward, const RewardComponent()],
  ['Offers', offer, const OfferComponent()],
  ['Referrals', referrals, const ReferralsComponent()]
];

List features = [
  [
    'Flight \nTickets',
    flight,
    'https://www.goindigo.in/?linkNav=Logo%7C%7CHeader'
  ],
  ['Bus Tickets', bus, 'https://www.redbus.in/bus-tickets'],
  ['Train Tickets', train, 'https://www.irctc.co.in/nget/train-search'],
  ['Movie Tickets', movie, 'https://in.bookmyshow.com/'],
  ['Event Tickets', event, 'https://in.bookmyshow.com/explore/events'],
  ['Hotels', hotel, 'https://www.oyorooms.com/'],
  ['Toll', toll, 'https://fastag.ihmcl.com/#hero-area'],
  ['uber cabs', uber, 'https://www.uber.com/global/en/cities/'],
];
