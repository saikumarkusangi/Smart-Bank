
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeColors.primary,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.shadowColor.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1), // changes position of shadow
                      ),
                    ],
                    
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 25,),
                      Text("Your Balance", style: TextStyle(color: Colors.grey, fontSize: 14, ),),
                      SizedBox(height: 10,),
                      Text("\$860,500.00", style: TextStyle(color: ThemeColors.secondary, fontSize: 18, fontWeight: FontWeight.w600 ),),
                    ],
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 0, right: 0,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ThemeColors.secondary,
                      shape: BoxShape.circle,
                      border: Border.all()
                    ),
                    child: Icon(Icons.add)
                  )
                )
            ],
    );
  }
}