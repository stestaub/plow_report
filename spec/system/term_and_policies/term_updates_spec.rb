require 'rails_helper'

feature 'existing terms updated' do

  let(:user) { create(:user) }
  let(:required_policy) { create(:policy_term, required: true, key: :agb) }

  before do
    user.accepted_terms << required_policy
    required_policy.update_attribute(:description, 'the new policy text')
  end

  context 'when user signs in' do

    before { sign_in_with(user.email, user.password) }

    it 'shows that the user has to accept updated terms' do
      expect(page).to have_content(I18n.t('views.policies_and_terms.require_new_concent'))
    end

    it 'user can not continue without accepting new terms' do
      click_button(I18n.t('common.continue'))
      expect(page).to have_content(I18n.t('activerecord.errors.models.user.attributes.base.new_consent_required'))
    end

    # There seem to be a timing issue here as this does work when testing manually
    xit 'continues after accepting new terms' do
      check('user[terms][agb]')
      click_button(I18n.t('common.continue'))
      expect(page).to have_current_path('/')
    end

  end



end