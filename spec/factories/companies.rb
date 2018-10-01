FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Winterdienst #{n} GmbH"}
    contact_email 'info@company.com'
    address 'Some Street 1'
    zip_code '8810'
    city 'Neustadt'
    options(drive_options: { track_distance: true, track_salting: true, track_plowing: true })
  end
  factory :company_registration, class: 'Company::Registration' do
    sequence(:name) { |n| "Winterdienst #{n} GmbH"}
    contact_email 'info@company.com'
    address 'Some Street 1'
    zip_code '8810'
    city 'Neustadt'
    add_owner_as_driver false
    transfer_private_drives false
  end
end
