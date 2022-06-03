import 'package:flutter/material.dart';
import 'package:seriestv_jobcity/data/models/schedule_model.dart';

class ScheduleWidget extends StatelessWidget {
  final Schedule schedule;
  const ScheduleWidget({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Schedule',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                width: 5.0,
              ),
              if (schedule.days!.isNotEmpty)
                Wrap(
                  children: schedule.days!
                      .map((e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Chip(label: Text(e)),
                          ))
                      .toList(),
                ),
              if (schedule.days!.isEmpty) const Text('No days'),
            ],
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: ' @ ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: schedule.time!.isEmpty ? 'No time' : schedule.time,
              style: Theme.of(context).textTheme.headline6!,
            )
          ])),
        ],
      ),
    );
  }
}
