import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications page'),
        ),
        floatingActionButton: BotonFlotante(),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int numero = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.bone,
            ),
            label: 'Bones'),
        BottomNavigationBarItem(
            // icon:
            icon: Stack(
              children: [
                FaIcon(
                  FontAwesomeIcons.bell,
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  // child: Icon(
                  //   Icons.brightness_1,
                  //   size: 10,
                  //   color: Colors.redAccent,
                  // ),
                  child: BounceInDown(
                    from: 10,
                    animate: (numero > 0) ? true : false,
                    child: Bounce(
                      from: 10,
                      controller: (controller) =>
                          Provider.of<_NotificationModel>(context)
                              .bounceController = controller,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: Colors.redAccent, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Text(
                          '$numero',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 7,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            label: 'Notifications'),
        BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.dog,
            ),
            label: 'MyDog'),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final model = Provider.of<_NotificationModel>(context, listen: false);

        model.numero++;

        if (model.numero >= 2) {
          final controller = model.bounceController;
          controller.forward(from: 0.0);
        }
      },
      backgroundColor: Colors.pink,
      child: FaIcon(FontAwesomeIcons.play),
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  int _numero = 0;
  late AnimationController _bounceController;

  int get numero => this._numero;

  set numero(int value) {
    this._numero = value;
    notifyListeners();
  }

  AnimationController get bounceController => this._bounceController;

  set bounceController(AnimationController controller) {
    this._bounceController = controller;
    // notifyListeners();
  }
}
