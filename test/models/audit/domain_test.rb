require 'test_helper'

describe Audit::Domain do
  describe :associations do
    subject { create_domain }

    specify { subject.master.wont_be_nil }
    specify { subject.domain_event.wont_be_nil }
  end

  describe :domain_contacts do
    subject { create_domain }

    context :when_contact_exists do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_contacts.count.must_equal 1 }
    end

    context :when_contact_created_then_removed do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction
        remove_domain_contact audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_contacts.empty?.must_equal true }
    end

    context :when_contact_created_then_removed_then_created_again do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction
        remove_domain_contact audit_transaction: subject.audit_transaction
        create_domain_contact audit_transaction: subject.audit_transaction
      end

      specify { subject.domain_contacts.count.must_equal 1 }
    end

    context :when_different_types do
      before do
        create_domain_contact audit_transaction: subject.audit_transaction

        remove_domain_contact audit_transaction: subject.audit_transaction,
                              type: Audit::DomainContact::BILLING_TYPE
      end

      specify { subject.domain_contacts.count.must_equal 2 }
    end
  end

  describe :as_json do
    subject { create_domain }

    let(:expected_json) {
      {
        partner:                    'alpha',
        domain:                     'domains.ph',
        authcode:                   'ABC123',
        period:                     1,
        registrant_handle:          'registrant',
        registered_at:              '2015-03-07T17:00:00Z',
        client_hold:                false,
        client_delete_prohibited:   false,
        client_renew_prohibited:    false,
        client_transfer_prohibited: false,
        client_update_prohibited:   false,
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end

  describe :register_domain? do
    specify { register_domain.register_domain?.must_equal true }
    specify { update_domain.register_domain?.must_equal false }
    specify { renew_domain.register_domain?.must_equal false }
  end

  describe :update_domain? do
    specify { update_domain.update_domain?.must_equal true }
    specify { register_domain.update_domain?.must_equal false }
    specify { renew_domain.update_domain?.must_equal false }
  end

  describe :renew_domain? do
    specify { renew_domain.renew_domain?.must_equal true }
    specify { register_domain.renew_domain?.must_equal false }
    specify { update_domain.renew_domain?.must_equal false }
  end
end