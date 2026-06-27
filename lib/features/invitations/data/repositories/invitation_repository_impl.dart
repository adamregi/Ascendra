import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/repositories/base_repository.dart';
import '../../domain/entities/invitation.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../models/invitation_model.dart';

class InvitationRepositoryImpl extends BaseRepository implements InvitationRepository {
  final supabase.SupabaseClient _client;

  InvitationRepositoryImpl(this._client);

  @override
  Future<Invitation> inviteMember({
    required String inviterId,
    required String distributorId,
    required String fullName,
    required String phone,
    required String companyId,
  }) async {
    try {
      final data = await _client.rpc(
        'create_invitation_atomic',
        params: {
          'p_inviter_id': inviterId,
          'p_distributor_id': distributorId,
          'p_full_name': fullName,
          'p_phone': phone,
          'p_company_id': companyId,
        },
      );
      return InvitationModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Invitation> acceptInvitation({required String invitationId}) async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) {
        throw supabase.AuthException('Must be authenticated to accept an invitation.');
      }

      final data = await _client.rpc(
        'accept_invitation_atomic',
        params: {
          'p_invitation_id': invitationId,
          'p_auth_user_id': user.id,
        },
      );
      return InvitationModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<void> cancelInvitation({required String invitationId}) async {
    try {
      await _client.rpc(
        'cancel_invitation_atomic',
        params: {
          'p_invitation_id': invitationId,
        },
      );
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<Invitation?> getInvitation({required String invitationId}) async {
    try {
      final data = await _client
          .from('invitations')
          .select()
          .eq('id', invitationId)
          .maybeSingle();

      if (data == null) return null;
      return InvitationModel.fromJson(data);
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<Invitation>> getInvitationsByInviter({
    required String inviterId,
  }) async {
    try {
      final List<dynamic> data = await _client
          .from('invitations')
          .select()
          .eq('inviter_id', inviterId);

      return data.map((e) => InvitationModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }

  @override
  Future<List<Invitation>> getPendingInvitations({
    required String companyId,
  }) async {
    try {
      final List<dynamic> data = await _client
          .from('invitations')
          .select()
          .eq('company_id', companyId)
          .eq('status', 'pending');

      return data.map((e) => InvitationModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stack) {
      handleException(e, stack);
    }
  }
}
