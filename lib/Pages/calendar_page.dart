import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:utility/Pages/appointment_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SfCalendar(
                timeZone: "Romance Standard Time",
                weekNumberStyle: WeekNumberStyle(backgroundColor: Theme.of(context).colorScheme.primary),
                showWeekNumber: true,
                showNavigationArrow: true,
                firstDayOfWeek: 1,
                viewHeaderHeight: 0,
                view: CalendarView.month,
                headerStyle: CalendarHeaderStyle(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  textAlign: TextAlign.center
                ),
                cellBorderColor: Theme.of(context).colorScheme.surface,
                todayHighlightColor: Theme.of(context).colorScheme.tertiary,
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectionDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary)
                ), 
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                // Data and Method
                initialSelectedDate: now,
                dataSource: _getCalendarDataSource(context),
                onLongPress: (CalendarLongPressDetails details) {
                  DateTime date = details.date!;
                  List appointments = details.appointments as List;
                  CalendarElement view = details.targetElement;
                              
                  showDialog(context: context, builder: (context) => AlertDialog(
                    content: ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text("${date.day}/${date.month}"),
                          title: Text(appointments[index].subject),
                        );
                      }
                    )
                  ));
                },
              ),
            ),
          ],
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => const AppointmentPage(),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add)
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource(context) {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(days:1, minutes: 10)),
    subject: 'Meeting',
    color: Theme.of(context).colorScheme.tertiary,
  ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
   appointments = source; 
  }
}