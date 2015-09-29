Before do
  Time.zone = "UTC"

  t = Time.zone.local(2015, 1, 1, 0, 0, 0)
  Timecop.freeze(t)
end

When(/^I add an ipv4 host address entry to an existing host$/) do
  client.expect :update, 'host/add_host_address_response'.epp do |command|
    command.as_json['add']['addr']['ipv4'].must_equal '255.255.255.255'
  end 

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv4_request'.json
  end
end

When(/^I add an ipv6 host address entry to an existing host$/) do
  client.expect :update, 'host/add_host_address_response'.epp do |command|
    command.as_json['add']['addr']['ipv6'].must_equal 'FE80:0000:0000:0000:0202:B3FF:FE1E:8329'
  end 

  EPP::Client.stub :new, client do
    post host_addresses_path('domain.ph'), 'host/add_ipv6_request'.json
  end
end

Then(/^ipv4 host address must be created$/) do
  client.verify
  json_response.must_equal 'host/add_ipv4_response'.json
end

Then(/^ipv6 host address must be created$/) do
  client.verify
  json_response.must_equal 'host/add_ipv6_response'.json
end