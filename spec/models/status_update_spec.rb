# == Schema Information
#
# Table name: status_updates
#
#  id         :integer          not null, primary key
#  status     :string(10)       not null
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe StatusUpdate, type: :model do
  describe "system_status=" do
    it "should convert string to upcased string" do
      @status_update = StatusUpdate.new

      @status_update.system_status = "foo"

      expect(@status_update.system_status).to eq ('FOO')
    end
  end

  describe "autofilling status" do

    describe "if status updates already exist" do
      before do
        StatusUpdate.create(system_status: "UP")
      end

      describe "if update already assigned a status" do
        it "should not change the status" do
          su = StatusUpdate.create(system_status: "DOWN", message: "foo")
          expect(su.system_status).to eq("DOWN")
        end
      end

      describe "if no status provided" do
        it "should set the status according to the last known status" do
          su = StatusUpdate.create()
          expect(su.system_status).to eq("UP")
        end
      end
    end

    describe "with no existing status updates" do
      it "should not autofill and rely on validation" do
        su = StatusUpdate.create()
        expect(su).to_not be_valid
      end
    end
  end
end
