// view/widgets/commits_widget.dart

// widgets pour récuperer des commentaires à travers un api externe
import 'package:entert_projet_01/model/user_api_model.dart';
import 'package:entert_projet_01/viewModel/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommitsWidgets extends StatelessWidget {
  final UserApiPublic user;
  const CommitsWidgets({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final changeColor = Provider.of<ChangeColor>(context);
    return Container(
      //padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(),
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor: changeColor.iconColor,
          child: Icon(Icons.person, size: 28, color: changeColor.textColor),
        ),
        title: Text(
          user.name,
          style: style(14, 2, changeColor.textColor),
        ),
        subtitle: Text(user.commits, style: style(12, 2, changeColor.textColor),),
      ),
    );
  }
}

// class fictive pour instancier un utolisateur quelconques de l'api public

