import 'package:budgets/business_logic/authentication/bloc/authentication_bloc.dart';
import 'package:budgets/presentation/screens/home/components/body_header.dart';
import 'package:budgets/presentation/screens/home/components/last_records.dart';
import 'package:budgets/presentation/widgets/widget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budgets/constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> homeWidgets = [
    SliverAppBar(
      brightness: Brightness.light,
      backgroundColor: kPrimayColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_on,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    ),
    SliverPersistentHeader(
      delegate: HeaderDelegate(),
    ),
    LastRecordsWidget(),
    WidgetCard(
      title: 'Spending',
      content: Container(
        width: double.infinity,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                  child:
                      Icon(Icons.donut_large, size: 150, color: Colors.orange)),
            ),
            Text(
              'Show more',
              textAlign: TextAlign.end,
              style: TextStyle(color: kAccentColor),
            )
          ],
        ),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: homeWidgets,
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Builder(
//               builder: (context) {
//                 final userId = context.select(
//                   (AuthenticationBloc bloc) => bloc.state.user.id,
//                 );
//                 return Text('UserID: $userId');
//               },
//             ),
//             ElevatedButton(
//               child: const Text('Logout'),
//               onPressed: () {
//                 context
//                     .read<AuthenticationBloc>()
//                     .add(AuthenticationLogoutRequested());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
