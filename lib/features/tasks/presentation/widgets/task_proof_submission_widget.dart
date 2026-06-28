import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_radius.dart';
import '../../domain/entities/task_proof.dart';

class TaskProofSubmissionWidget extends ConsumerStatefulWidget {
  final String taskId;
  final VoidCallback? onSubmitSuccess;

  const TaskProofSubmissionWidget({
    super.key,
    required this.taskId,
    this.onSubmitSuccess,
  });

  @override
  ConsumerState<TaskProofSubmissionWidget> createState() =>
      _TaskProofSubmissionWidgetState();
}

class _TaskProofSubmissionWidgetState
    extends ConsumerState<TaskProofSubmissionWidget> {
  TaskProofType _selectedType = TaskProofType.text;
  bool _isSubmitting = false;

  // State for Text
  final _textController = TextEditingController();

  // State for URL
  final _urlController = TextEditingController();

  // State for Image/File
  File? _selectedFile;
  String? _fileName;

  @override
  void dispose() {
    _textController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _fileName = pickedFile.name;
      });
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  Future<void> _submitProof() async {
    setState(() => _isSubmitting = true);

    try {
      // 1. Storage Upload (Mocked for UI flow)
      // If _selectedType is image or pdf, we would upload to Supabase Storage
      // final path = await _storageService.uploadFile(_selectedFile!);
      // final publicUrl = await _storageService.getPublicUrl(path);

      await Future.delayed(const Duration(seconds: 2));

      // 2. RPC call `submit_task_proof`
      // await ref.read(taskRepositoryProvider).submitProof(
      //   taskId: widget.taskId,
      //   proofType: _selectedType,
      //   text: _textController.text,
      //   url: _urlController.text,
      //   storagePath: 'mock/path/file.jpg',
      //   ...
      // );

      if (mounted && widget.onSubmitSuccess != null) {
        widget.onSubmitSuccess!();
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Text(
              'Submit Task Proof',
              style: TextStyle(
                fontFamily: 'Newsreader',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.borderSubtle),

          // Type Selector
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Row(
                children: [
                  _buildTypeTab(
                    TaskProofType.text,
                    'Text',
                    LucideIcons.alignLeft,
                  ),
                  _buildTypeTab(
                    TaskProofType.image,
                    'Image',
                    LucideIcons.image,
                  ),
                  _buildTypeTab(TaskProofType.pdf, 'PDF', LucideIcons.fileText),
                  _buildTypeTab(TaskProofType.url, 'URL', LucideIcons.link),
                ],
              ),
            ),
          ),

          // Dynamic Input Area
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildInputArea(),
            ),
          ),

          // Footer / Submit
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitProof,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child:
                    _isSubmitting
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.onPrimary,
                            strokeWidth: 2,
                          ),
                        )
                        : const Text(
                          'Submit Proof',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeTab(TaskProofType type, String label, IconData icon) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedType = type;
            _selectedFile = null;
            _fileName = null;
          });
        },
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                      ),
                    ]
                    : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color:
                    isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Hanken Grotesk',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color:
                      isSelected
                          ? AppColors.primary
                          : AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    switch (_selectedType) {
      case TaskProofType.text:
        return _buildTextField(
          key: const ValueKey('text'),
          controller: _textController,
          hint: 'Describe your completion or provide numbers...',
          minLines: 4,
        );
      case TaskProofType.url:
        return _buildTextField(
          key: const ValueKey('url'),
          controller: _urlController,
          hint: 'https://...',
          icon: LucideIcons.link2,
        );
      case TaskProofType.image:
        return _buildFilePickerArea(
          key: const ValueKey('image'),
          onPick: _pickImage,
          icon: LucideIcons.imagePlus,
          label: 'Upload a Photo or Screenshot',
        );
      case TaskProofType.pdf:
        return _buildFilePickerArea(
          key: const ValueKey('pdf'),
          onPick: _pickFile,
          icon: LucideIcons.filePlus,
          label: 'Upload a PDF Document',
        );
    }
  }

  Widget _buildTextField({
    required Key key,
    required TextEditingController controller,
    required String hint,
    int minLines = 1,
    IconData? icon,
  }) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: minLines > 1 ? null : 1,
        style: const TextStyle(fontSize: 15, color: AppColors.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.borderSubtle),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(AppSpacing.md),
          prefixIcon:
              icon != null ? Icon(icon, color: AppColors.borderSubtle) : null,
        ),
      ),
    );
  }

  Widget _buildFilePickerArea({
    required Key key,
    required VoidCallback onPick,
    required IconData icon,
    required String label,
  }) {
    return Container(
      key: key,
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.borderSubtle,
          style: BorderStyle.solid,
        ),
      ),
      child:
          _selectedFile == null
              ? Column(
                children: [
                  Icon(icon, size: 48, color: AppColors.borderSubtle),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  OutlinedButton(
                    onPressed: onPick,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.borderSubtle),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                    ),
                    child: const Text('Select File'),
                  ),
                ],
              )
              : Row(
                children: [
                  Icon(
                    LucideIcons.fileCheck2,
                    color: const Color(0xFF10b981),
                    size: 32,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      _fileName ?? 'Selected File',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.x,
                      color: AppColors.onSurfaceVariant,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedFile = null;
                        _fileName = null;
                      });
                    },
                  ),
                ],
              ),
    );
  }
}
