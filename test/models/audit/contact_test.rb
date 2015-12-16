require 'test_helper'

describe Audit::Contact do
  describe :as_json do
    subject { build :audit_contact }

    let(:expected_json) {
      {
        partner:            'alpha',
        handle:             'handle',
        name:               'Contact Name',
        organization:       'Contact Organization',
        street:             'Contact Street',
        street2:            'Contact Street 2',
        street3:            'Contact Street 3',
        city:               'Contact City',
        state:              'Contact State',
        postal_code:        '1234',
        country_code:       'PH',
        local_name:         'Local Contact Name',
        local_organization: 'Local Contact Organization',
        local_street:       'Local Contact Street',
        local_street2:      'Local Contact Street 2',
        local_street3:      'Local Contact Street 3',
        local_city:         'Local Contact City',
        local_state:        'Local Contact State',
        local_postal_code:  'Local 1234',
        local_country_code: 'Local PH',
        voice:              '+63.21234567',
        voice_ext:          '1234',
        fax:                '+63.21234567',
        fax_ext:            '1235',
        email:              'test@contact.ph'
      }
    }

    specify { subject.as_json.must_equal expected_json }
  end
end