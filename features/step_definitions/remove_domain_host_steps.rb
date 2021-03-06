When /^I try to remove a domain host from a domain$/ do
  client = double('client')

  expect(client).to receive(:update).and_return('domains/domain.ph/update_response'.epp)
  expect(EPP::Client).to receive(:new) { client }

  delete domain_host_path('domain.ph', 'ns5.domains.ph')
end

When /^I try to remove a domain host from a domain and fails$/ do
  client = double('client')

  expect(client).to receive(:update).and_return('domains/domain.ph/update_response_failed'.epp)
  expect(EPP::Client).to receive(:new) { client }

  delete domain_host_path('domain.ph', 'ns5.domains.ph')
end

When /^I try to remove a domain host with no domain$/ do
  delete domain_host_path(' ', 'ns5.domains.ph')
end

When /^I try to remove a domain host with no name$/ do
  delete domain_host_path('domain.ph', ' ')
end

Then /^domain must no longer have domain host$/ do
  expect(json_response).to eql 'domains/domain.ph/hosts/ns5.domains.ph/delete_response'.json
end
