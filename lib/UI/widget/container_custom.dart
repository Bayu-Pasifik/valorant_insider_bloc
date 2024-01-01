import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valorant_insider_bloc/UI/constant/constant.dart';
import 'package:valorant_insider_bloc/UI/screen/Agent/agent_view.dart';
import 'package:valorant_insider_bloc/UI/screen/Buddies/buddies.dart';

class ContainerToClip extends StatelessWidget {
  const ContainerToClip(
    this.text,
    this.assets, {
    required this.isImageOnLeft,
    required this.to,
    super.key,
  });

  final String text;
  final String assets;
  final bool isImageOnLeft;
  final String to;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => to == "agent"
      //     ? Get.toNamed(Routes.AGENT)
      //     : to == "buddies"
      //         ? Get.toNamed(Routes.BUDDIES)
      //         : to == "map"
      //             ? Get.toNamed(Routes.MAP)
      //             : to == "playercard"
      //                 ? Get.toNamed(Routes.PLAYER_CARD)
      //                 : to == "playerTitle"
      //                     ? Get.toNamed(Routes.PLAYER_TITLE)
      //                     : Get.toNamed(Routes.WEAPON),

      onTap: () => to == "agent"
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AgentView(),
              ))
          : to == "buddies"
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BuddiesView(),
                  ))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgentView(),
                  )),
      child: Container(
        height: 160,
        padding: const EdgeInsets.all(20),
        // color: color,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [redbackground, blackgroundColor])),
        child: Row(
          children: [
            if (isImageOnLeft)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(assets),
                ),
              ),
            Expanded(
              child: Text(
                text.toUpperCase(),
                style: GoogleFonts.bowlbyOneSc(color: Colors.white),
              ),
            ),
            if (!isImageOnLeft)
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset(assets),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
