require 'rails_helper'

feature 'creating a drive on dashboard' do
  let(:user) { create(:user) }
  let(:current_driver) { user.drivers.last }

  before do
    visit '/users/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: attributes_for(:user)[:password]
    click_button 'Anmelden'
  end

  describe 'by filling in drive form' do
    it 'should redirect to drives and show new drives' do
      visit '/'
      # fill in start and end time
      attrs = { start: 1.hour.ago, end: 0.5.hour.ago, distance_km: 15.1, plowed: true, salted: true, salt_refilled: true, salt_amount_tonns: 3.41 }
      fill_form 'drive', attrs

      # create drive
      click_button I18n.t('dashboard.cards.new_drive.create')

      expect(page).to have_current_path('/drives')

      # Test if drive is listed
      # drive options
      expect(page).to have_content I18n.t('activerecord.attributes.drive.plowed')
      expect(page).to have_content I18n.t('activerecord.attributes.drive.salted')
      expect(page).to have_content I18n.t('activerecord.attributes.drive.salt_refilled')

      expect(page).to have_content '3,41' # salt amount tonns
      expect(page).to have_content '15,1' # distance in km
      expect(page).to have_content '00:30'
    end
  end

  context 'with existing drive of same type', js: true do
    # Currently skipping js tests until selenium is setup correctly
    let(:existing_drive) { create(:drive, driver: current_driver, plowed: true, salted: false, salt_refilled: false) }

    before { existing_drive }

    xit 'should pre populate the km field' do
      check 'drive[plowed]'
      expect(find_field(name: 'drive[distance_km]').value).to eq existing_drive.distance_km
    end

  end

end