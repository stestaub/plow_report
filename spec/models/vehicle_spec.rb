# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vehicle, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:company_id, :discarded_at) }

  it { is_expected.to belong_to(:company) }

  describe "discard" do
    subject { create(:vehicle) }
    it { is_expected.not_to be_discarded }

    context "discarded" do
      before { subject.discard }
      it { is_expected.not_to validate_uniqueness_of(:name) }
    end
  end
end