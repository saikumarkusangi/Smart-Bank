import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_controller.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({super.key});

  @override
  Widget build(BuildContext context) {
        final userDataProvider = Provider.of<UserController>(context);
    return Stack(
      children: [
        SizedBox(
         child: Image.asset('assets/images/card_template.png')
        ),
        Positioned(
          top:5,right:20,
          child: SizedBox(
          width: 150,
          child: Image.asset('assets/images/banner.png'))
        ),
            Positioned(
          top:70,right:20,
          child: SizedBox(
          
          child: Text(userDataProvider.upiId,style:TextStyle(color:Colors.white,fontSize:18,),))
        ),
         Positioned(
          bottom:50,left:20,
          child: SizedBox(
          
          child: Text('XXXX XXXX XXXX XXXX',style:TextStyle(color:Colors.white.withOpacity(0.4),fontSize:18,),))
        ),
         Positioned(
          bottom:20,left:20,
          child: SizedBox(
          child: Text(userDataProvider.fullName,style:TextStyle(color:Colors.white,fontSize:18,),))
        )
       
      
      ],
    );
  }
}