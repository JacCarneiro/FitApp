import 'package:fit_app/application/components/widgets/defaultAppBar.widget.dart';
import 'package:fit_app/application/components/widgets/footer.widget.dart';
import 'package:fit_app/application/entities/schedule.entity.dart';
import 'package:fit_app/application/infra/@providers/User.provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final schedule = Schedule(date: selectedDate, time: selectedTime);

      // Verifica se já existe um agendamento para o mesmo dia e horário
      if (_isTimeSlotTaken(userProvider.activeUser?.schedules ?? [], schedule)) {
        // Exibe uma mensagem para o usuário informando que o horário está ocupado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Horário já ocupado! Tente outro horário.")),
        );
      } else {
        // Se não houver conflito, adiciona o agendamento
        userProvider.addSchedule(schedule);
        setState(() {});
      }
    }
  }

  // Função para verificar se o horário já está ocupado
  bool _isTimeSlotTaken(List<Schedule> schedules, Schedule newSchedule) {
    for (var existingSchedule in schedules) {
      // Verifica se o agendamento é para o mesmo dia e hora
      if (isSameDay(existingSchedule.date, newSchedule.date) && 
          existingSchedule.time == newSchedule.time) {
        return true; // O horário está ocupado
      }
    }
    return false; // O horário está disponível
  }

  void _deleteAppointment(int index) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.activeUser?.schedules.removeAt(index);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final schedules = userProvider.activeUser?.schedules ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Consulta'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'SELECIONE O DIA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 350,
                      child: TableCalendar(
                        focusedDay: selectedDate,
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        selectedDayPredicate: (day) =>
                            isSameDay(selectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            selectedDate = selectedDay;
                          });
                        },
                        calendarStyle: const CalendarStyle(
                          todayTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          selectedDecoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Horário:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context),
                          child: const Text("Selecionar Horário"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Compromissos agendados:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    schedules.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("Nenhum agendamento ainda."),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: schedules.length,
                            itemBuilder: (context, index) {
                              final schedule = schedules[index];
                              return ListTile(
                                title: Text(schedule.formattedDateTime),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deleteAppointment(index),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
          ),
          FooterWidget(),
        ],
      ),
    );
  }
}
