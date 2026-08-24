
import 'package:flutter/material.dart';
import '../appwrite_interface.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../localDB.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '../../app_state.dart';

class TemplatesPageWidget extends StatefulWidget {
  const TemplatesPageWidget({super.key});

  @override
  State<TemplatesPageWidget> createState() => _TemplatesPageWidgetState();
}

class _TemplatesPageWidgetState extends State<TemplatesPageWidget> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<TemplatesRecord>? _allTemplates;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<TemplatesRecord> templates = await listTemplateList(currentUser!.reference);
      setState(() {
        _allTemplates = templates
            .where((t) =>
                t.isMaster == true ||
                t.creatorId?.path == currentUser?.reference?.path)
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading templates: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addTemplate(TemplatesRecord? sourceTemplate) {
    TextEditingController nameController = TextEditingController();
    bool isMaster = false;
    if (sourceTemplate != null) {
      nameController.text = '${sourceTemplate.name} (Copy)';
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title:
                Text(sourceTemplate == null ? 'New Template' : 'Copy Template'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Template Name'),
                ),
                if (currentUser?.userLevel == kUserLevelSupervisor)
                  Row(
                    children: [
                      Checkbox(
                        value: isMaster,
                        onChanged: (val) {
                          setDialogState(() {
                            isMaster = val ?? false;
                          });
                        },
                      ),
                      Text('Master Template'),
                    ],
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
                    Navigator.pop(context);
                    try {
                      await createTemplate(
                        name: name,
                        questions: sourceTemplate?.questions?.toList() ?? [],
                        isMaster: isMaster,
                        creatorId: currentUser!.reference!,
                      );
                      _loadTemplates();
                    } catch (e) {
                      print('Error creating template: $e');
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

  void _editQuestions(TemplatesRecord template) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionsEditPage(
          template: template,
          onSave: (updatedQuestions) async {
            await updateTemplateQuestions(
                template.reference!, updatedQuestions);
            _loadTemplates();
          },
        ),
      ),
    );
  }

  void _deleteTemplate(TemplatesRecord template) async {
    bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Delete Template'),
              content:
                  Text('Are you sure you want to delete "${template.name}"?'),
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
      await deleteTemplate(template.reference!);
      _loadTemplates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Templates', style: TextStyle(color: Colors.white)),
        backgroundColor: FlutterFlowTheme.of(context).primary,
        iconTheme: IconThemeData(color: Colors.white),
        actions:[
          FlutterFlowIconButton(
            caption: 'Create\ntemplate',
            buttonWidth: 150,
            enabled: true,
            fillColor: Colors.white,
            tooltipMessage: 'Create Session',
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 50,
            onPressed: () {
              _addTemplate(null);
            },
            icon: kIconAdd,
          ),
        ]
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _allTemplates?.length ?? 0,
              itemBuilder: (context, index) {
                final template = _allTemplates![index];
                final isOwner =
                    template.creatorId?.path == currentUser?.reference?.path;
                print('(TP1)${template.creatorId?.path}....${currentUser?.reference?.path}');
                // Supervisors can also delete/edit master templates if needed, but per requirements: "all users access these as read-only. Each user can only access master templates and those they created."
                // Wait, if a supervisor created a master template, they are its owner, so they can delete it anyway!
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(template.name ?? 'Unnamed',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${template.questions?.length ?? 0} questions ${template.isMaster == true ? '(Master)' : ''}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () => _addTemplate(template),
                          tooltip: 'Copy',
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editQuestions(template),
                          tooltip: 'View/Edit Questions',
                        ),
                        (isOwner) ?
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTemplate(template),
                            tooltip: 'Delete',
                          ) :
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {},
                          tooltip: 'Delete',
                        )

                        ,
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

class QuestionsEditPage extends StatefulWidget {
  final TemplatesRecord template;
  final Function(List<String>) onSave;

  const QuestionsEditPage(
      {super.key, required this.template, required this.onSave});

  @override
  State<QuestionsEditPage> createState() => _QuestionsEditPageState();
}

class _QuestionsEditPageState extends State<QuestionsEditPage> {
  late List<String> _questions;

  @override
  void initState() {
    super.initState();
    _questions = List.from(widget.template.questions ?? []);
  }

  void _addQuestion() {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add Question'),
              content: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter question text'),
                maxLines: 3,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      setState(() {
                        _questions.add(controller.text.trim());
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ));
  }

  void _editQuestion(int index) {
    TextEditingController controller =
        TextEditingController(text: _questions[index]);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Edit Question'),
              content: TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter question text'),
                maxLines: 3,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      setState(() {
                        _questions[index] = controller.text.trim();
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final canEdit =
        widget.template.creatorId?.path == currentUser?.reference?.path;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.template.name} - Questions',
            style: TextStyle(color: Colors.white)),
        backgroundColor: FlutterFlowTheme.of(context).primary,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [

          FlutterFlowIconButton(
            enabled: true,
            fillColor: Colors.white,
            tooltipMessage: 'Add Question',
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 40,
            onPressed: () {
              _addQuestion();

            },
            icon: kIconAdd,
          ),

/*

          if (canEdit)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                widget.onSave(_questions);
                Navigator.pop(context);
              },
            ),
*/
          SizedBox(width: kIconButtonGap),

          if (canEdit)
            FlutterFlowIconButton(
            enabled: true,
            fillColor: Colors.white,
            tooltipMessage: 'Add Question',
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 40,
            onPressed: () {
              widget.onSave(_questions);
              Navigator.pop(context);

            },
            icon: Icon(Icons.save),
          ),


        ],
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(_questions[index]),
            trailing: canEdit
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editQuestion(index)),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _questions.removeAt(index);
                            });
                          }),
                    ],
                  )
                : null,
          );
        },
      ),
      /*floatingActionButton: canEdit
          ? FloatingActionButton(
        foregroundColor: Colors.white,
              onPressed: _addQuestion,
              child: Icon(Icons.add),
              backgroundColor: FlutterFlowTheme.of(context).primary,
            )
          : null,*/
    );
  }
}
