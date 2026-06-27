import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'supabase_provider.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/invitations/domain/repositories/invitation_repository.dart';
import '../../features/invitations/data/repositories/invitation_repository_impl.dart';
import '../../features/subscriptions/domain/repositories/subscription_repository.dart';
import '../../features/subscriptions/data/repositories/subscription_repository_impl.dart';
import '../../features/meetings/domain/repositories/meeting_repository.dart';
import '../../features/meetings/data/repositories/meeting_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/followups/domain/repositories/followup_repository.dart';
import '../../features/followups/data/repositories/followup_repository_impl.dart';
import '../../features/compliance/domain/repositories/compliance_repository.dart';
import '../../features/compliance/data/repositories/compliance_repository_impl.dart';

/// Provider for [AuthRepository].
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return AuthRepositoryImpl(client);
});

/// Provider for [InvitationRepository].
final invitationRepositoryProvider = Provider<InvitationRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return InvitationRepositoryImpl(client);
});

/// Provider for [SubscriptionRepository].
final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SubscriptionRepositoryImpl(client);
});

/// Provider for [MeetingRepository].
final meetingRepositoryProvider = Provider<MeetingRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return MeetingRepositoryImpl(client);
});

/// Provider for [TaskRepository].
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return TaskRepositoryImpl(client);
});

/// Provider for [FollowUpRepository].
final followUpRepositoryProvider = Provider<FollowUpRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return FollowUpRepositoryImpl(client);
});

/// Provider for [ComplianceRepository].
final complianceRepositoryProvider = Provider<ComplianceRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return ComplianceRepositoryImpl(client);
});
