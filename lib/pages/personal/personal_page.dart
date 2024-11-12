import 'package:flutter/cupertino.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});
  @override createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child:
        Row(
          children: [
            Text('PersonalPage'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,)
    );
  }
}

