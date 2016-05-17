require 'rails_helper'

describe "status page" do
  describe "GET /" do
    describe "happy path" do
      before do
        visit "/"
      end

      it "should be successful" do  
        expect(page.status_code).to eq 200
      end
    end

    describe "empty state" do
      before do
        visit "/"
      end

      it "should be successful" do  
        expect(page.status_code).to eq 200
      end

      it "should display that there are no status updates yet" do
        expect(page).to have_content("There have been no status updates.")
      end
    end

    describe "UP state" do
      before do
        StatusUpdate.create(system_status: "UP", message: "foo")
        visit "/"
      end

      it "should be successful" do  
        expect(page.status_code).to eq 200
      end

      it "should not display empty state" do
        expect(page).to have_no_content("There have been no status updates.")
      end 

      it "should display jumbotron with current status" do
        expect(page).to have_css('.jumbotron.up')
      end     
    end

    describe "DOWN state" do
      before do
        StatusUpdate.create(system_status: "DOWN", message: "foo")
        visit "/"
      end

      it "should be successful" do  
        expect(page.status_code).to eq 200
      end

      it "should not display empty state" do
        expect(page).to have_no_content("There have been no status updates.")
      end 

      it "should display jumbotron with current status" do
        expect(page).to have_css('.jumbotron.down')
      end     
    end
  end
end

