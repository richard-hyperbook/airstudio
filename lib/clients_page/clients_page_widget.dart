import 'package:flutter/material.dart';
import '../appwrite_interface.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '../../app_state.dart';

class ClientsPageWidget extends StatefulWidget {
  const ClientsPageWidget({super.key});

  @override
  State<ClientsPageWidget> createState() => _ClientsPageWidgetState();
}

class _ClientsPageWidgetState extends State<ClientsPageWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<UsersRecord>? _allClients;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClients();
  }

  Future<void> _loadClients() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<UsersRecord> clients = await listUsersClientsOfUser(therapist: currentUser!.reference);
      setState(() {
        _allClients = clients;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading clients: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addClient(UsersRecord? sourceClient) {
    TextEditingController nameController = TextEditingController();
    if (sourceClient != null) {
      nameController.text = '${sourceClient.displayName} (Copy)';
    }
    print('(CC0)${nameController.text}');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title:
            Text(sourceClient == null ? 'New Client' : 'Copy Client'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Client Name'),
                ),

              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  String name = nameController.text.trim();
                  if (name.isNotEmpty) {
                    print('(CC1)${name}');
                    Navigator.pop(context);
                    print('(CC2)${nameController.text.trim()}....${currentUser!.reference!.path}');
                    try {
                      await createClient(
                        displayName: nameController.text.trim(),
                        therapistId: currentUser!.reference!.path,
                      );
                      _loadClients();
                    } catch (e) {
                      print("Error creating client's record: $e");
                    }
                  }
                },
                child: Text('Create'),
              ),
            ],
          );
        });
      },
    );
  }

  void _deleteClient(UsersRecord client) async {
    bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete Client'),
          content:
          Text('Are you sure you want to delete "${client.displayName}"?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Delete')),
          ],
        ));

    if (confirm!) {
      await deleteTemplate(client.reference!);
      _loadClients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: Text('Clients', style: TextStyle(color: Colors.white)),
          backgroundColor: FlutterFlowTheme.of(context).primary,
          iconTheme: IconThemeData(color: Colors.white),
          actions:[
            FlutterFlowIconButton(
              caption: 'Add\nclient',
              buttonWidth: 105,
              enabled: true,
              fillColor: Colors.white,
              tooltipMessage: 'Add client',
              borderColor: FlutterFlowTheme.of(context).primary,
              borderRadius: 30,
              borderWidth: 1,
              buttonSize: 50,
              onPressed: () {
                _addClient(null);
              },
              icon: kIconAdd,
            ),
          ]
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _allClients?.length ?? 0,
        itemBuilder: (context, index) {
          final client = _allClients![index];
          final isOwner =
              client.therapistId == currentUser?.reference?.path;
          print('(TP1)${client.therapistId}....${currentUser?.reference?.path}');
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(client.displayName ?? 'Unnamed',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Container(),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () => _addClient(client),
                    tooltip: 'Copy',
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.edit),
                  //   onPressed: () => _editQuestions(template),
                  //   tooltip: 'View/Edit Questions',
                  // ),
                  if (isOwner)
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteClient(client),
                      tooltip: 'Delete',
                    ),
                ],
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _addTemplate(null),
      //   child: Icon(Icons.add),
      //   backgroundColor: FlutterFlowTheme.of(context).primary,
      // ),
    );
  }
}

