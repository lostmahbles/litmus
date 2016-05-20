require 'rails_helper'

describe "Status API" do

  describe "creating status update" do

    before do
      StatusUpdate.create(system_status: "UP", message: "foo")
    end

    describe "updating with message only" do
      it "should succeed and change only the message" do
        post '/api/v1/status', message: "bar"

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        # check to make sure the right amount of messages are returned
        expect(json['current_status']['system_status']).to eq("UP")
        expect(json['current_status']['message']).to eq("bar")
      end
    end

    describe "updating with status only" do
      it "should update the status" do
        post '/api/v1/status', system_status: "DOWN"

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        # check to make sure the right amount of messages are returned
        expect(json['current_status']['system_status']).to eq("DOWN")
      end

      it "should clear the message" do
        post '/api/v1/status', system_status: "DOWN"

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        expect(json['current_status']['message']).to eq(nil)
      end
    end

    describe "updating status and message" do
      it "should update both status and message" do 
        post '/api/v1/status', system_status: "DOWN", message: "This is my message"

        json = JSON.parse(response.body)

        # test for the 200 status-code
        expect(response).to be_success

        # check to make sure the right amount of messages are returned
        expect(json['current_status']['system_status']).to eq("DOWN")
        expect(json['current_status']['message']).to eq("This is my message")
      end
    end

    describe "error handling" do
      describe "with invalid status" do
        before do
          post '/api/v1/status', system_status: "FOO"
          @json = JSON.parse(response.body)
        end

        it "should fail" do
          # test for bad request
          expect(response.status).to eq(400)
        end

        it "should give useful error message w possible options" do
          expect(@json['errors']['system_status'][0]).to match /UP or DOWN/
        end

        it "should not change the current status" do
          # check to make sure the status didn't change
          expect(@json['current_status']['system_status']).to eq("UP")
          expect(@json['current_status']['message']).to eq("foo")
        end
      end
    end
  end 
end