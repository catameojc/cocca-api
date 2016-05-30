When /^I try to add a domain host to a domain$/ do
  client = double('client')

  expect(client).to receive(:update).and_return('domains/domain.ph/hosts/create_response'.epp)
  expect(EPP::Client).to receive(:new) { client }

  post domain_hosts_path('domain.ph'), 'domains/domain.ph/hosts/post_request'.json
end

When /^I try to add a domain host to a domain and fails$/ do
  client = double('client')

  expect(client).to receive(:update).and_return('domains/domain.ph/hosts/create_failed_response'.epp)
  expect(EPP::Client).to receive(:new) { client }

  post domain_hosts_path('domain.ph'), 'domains/domain.ph/hosts/post_request'.json
end

When /^I try to add a domain host with no domain$/ do
  post domain_hosts_path(' ')
end

When /^I try to add a domain host with no name$/ do
  post domain_hosts_path('doman.ph'), {}
end

Then /^domain must now have domain host$/ do
  expect(json_response).to eql 'domains/domain.ph/hosts/post_response'.json
end
