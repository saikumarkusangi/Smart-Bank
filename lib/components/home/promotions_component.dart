import 'package:bank/components/components.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../models/models.dart';
import '../../utils/utils.dart';

class PromotionsList extends StatelessWidget {
  const PromotionsList({
    Key? key,
    required this.getPromotionsList,
  }) : super(key: key);

  final List<PeopleModel> getPromotionsList;

  @override
  Widget build(BuildContext context) {
    return PromotionsListComponent(getPromotionsList: getPromotionsList);
  }
}

class PromotionsListComponent extends StatefulWidget {
  const PromotionsListComponent({
    Key? key,
    required this.getPromotionsList,
  }) : super(key: key);

  final List<PeopleModel> getPromotionsList;

  @override
  _PromotionsListComponentState createState() => _PromotionsListComponentState();
}

class _PromotionsListComponentState extends State<PromotionsListComponent> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.getPromotionsList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 2.0, crossAxisSpacing: 4.0, childAspectRatio: 1.0),
      itemBuilder: (context, index) {
        PeopleModel mData = widget.getPromotionsList[index];
        return Column(
          children: [
            CircleAvatar(radius: 26, backgroundColor: black, backgroundImage: AssetImage(mData.userImg)),
            5.height,
            Text(mData.userName, style: Theme.of(context).textTheme.bodySmall),
          ],
        ).onTap(() {
          if (index == 0) {
            const RewardComponent().launch(context);
          } else if (index == 1) {
            const OfferComponent().launch(context);
          } else if (index == 2) {
            const ReferralsComponent().launch(context);
          }
        });
      },
    );
  }
}
