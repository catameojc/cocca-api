class TransferDomainJob < ActiveJob::Base
  include SyncJob
  
  URL = Rails.configuration.x.registry_url
  
  queue_as :sync_cocca_jobs
  
  def perform record
    json_request = {
      partner:        record[:partner],
      currency_code:  'USD',
      ordered_at:      record[:registered_at],
      order_details:  [
        {
          type:               'transfer_domain',
          domain:             record[:domain],
          authcode:           record[:authcode],
          period:             record[:period],
          registrant_handle:  record[:registrant_handle]
        }
      ]
    }
    
    execute :post, path: "#{URL}/orders", body: json_request
  end

end