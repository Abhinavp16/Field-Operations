import 'package:flutter/material.dart';

class CheckpointRecord {
  const CheckpointRecord({required this.name, required this.status});

  final String name;
  final String status;

  CheckpointRecord copyWith({String? status}) {
    return CheckpointRecord(name: name, status: status ?? this.status);
  }
}

class ActivityRecord {
  const ActivityRecord({
    required this.time,
    required this.title,
    required this.status,
  });

  final String time;
  final String title;
  final String status;
}

class FieldOpsState extends ChangeNotifier {
  bool operationActive = true;
  int operationDrafts = 0;
  int incidentReports = 2;
  int offlineQueue = 4;

  final List<CheckpointRecord> checkpoints = [
    const CheckpointRecord(name: 'CP-01 Alpha', status: 'Completed'),
    const CheckpointRecord(name: 'CP-02 Bravo', status: 'Active'),
    const CheckpointRecord(name: 'CP-03 Charlie', status: 'Pending'),
  ];

  final List<ActivityRecord> activities = [
    const ActivityRecord(
      time: '09:24',
      title: 'Checkpoint CP-02 updated',
      status: 'Completed',
    ),
    const ActivityRecord(
      time: '09:11',
      title: 'Incident report submitted',
      status: 'Review',
    ),
    const ActivityRecord(
      time: '08:52',
      title: 'Team Bravo joined operation',
      status: 'Active',
    ),
    const ActivityRecord(
      time: '08:31',
      title: 'Offline map pack verified',
      status: 'Ready',
    ),
  ];

  int get completedCheckpoints =>
      checkpoints.where((item) => item.status == 'Completed').length;
  int get alertCount => incidentReports;
  String get operationStatus => operationActive ? 'Active' : 'Closed';

  void saveOperationDraft(String name) {
    operationDrafts += 1;
    _addActivity(
      'Draft saved: ${name.isEmpty ? 'New operation' : name}',
      'Draft',
    );
  }

  void submitIncident(String severity) {
    incidentReports += 1;
    offlineQueue += 1;
    _addActivity('$severity incident report submitted', 'Queued');
  }

  void completeActiveCheckpoint() {
    final activeIndex = checkpoints.indexWhere(
      (item) => item.status == 'Active',
    );
    if (activeIndex == -1) return;

    checkpoints[activeIndex] = checkpoints[activeIndex].copyWith(
      status: 'Completed',
    );
    if (activeIndex + 1 < checkpoints.length) {
      checkpoints[activeIndex + 1] = checkpoints[activeIndex + 1].copyWith(
        status: 'Active',
      );
    }
    offlineQueue += 1;
    _addActivity('${checkpoints[activeIndex].name} marked complete', 'Synced');
  }

  void closeOperation() {
    operationActive = false;
    _addActivity('Bridge Safety Sweep closed', 'Debrief');
  }

  void reopenOperation() {
    operationActive = true;
    _addActivity('Bridge Safety Sweep reopened', 'Active');
  }

  void _addActivity(String title, String status) {
    activities.insert(
      0,
      ActivityRecord(time: _timeNow(), title: title, status: status),
    );
    notifyListeners();
  }

  String _timeNow() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}

class FieldOpsStateScope extends InheritedNotifier<FieldOpsState> {
  const FieldOpsStateScope({
    required FieldOpsState state,
    required super.child,
    super.key,
  }) : super(notifier: state);

  static FieldOpsState of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<FieldOpsStateScope>();
    assert(scope != null, 'FieldOpsStateScope not found in widget tree');
    return scope!.notifier!;
  }
}
