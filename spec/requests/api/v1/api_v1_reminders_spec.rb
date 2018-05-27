require 'rails_helper'

RSpec.describe 'Api::V1::Reminders', type: :request do
  describe 'GET /api/v1/reminders' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :get, '/api/v1/reminders'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @reminders = create_list(:reminder, 2, user: @user)
        get '/api/v1/reminders', params: {}, headers: header_with_authentication(@user)
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it "returns a reminders' list" do
        @reminders.each_with_index do |reminder, index|
          json_reminder = JSON.parse(reminder.to_json)
          expect(json[index]).to eq(json_reminder)
        end
      end
    end
  end

  describe 'GET /api/v1/reminders/id' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :get, '/api/v1/reminders/1'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @reminder = create(:reminder, user: @user)
        get '/api/v1/reminders', params: { id: @reminder.id }, headers: header_with_authentication(@user)
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the reminder' do
        expect(json.first).to eq(JSON.parse(@reminder.to_json))
      end
    end
  end

  describe 'POST /api/v1/reminders' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :post, '/api/v1/reminders/'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @reminder_attributes = attributes_for(:reminder)
        post(
          '/api/v1/reminders',
          params: { reminder: @reminder_attributes },
          headers: header_with_authentication(@user)
        )
      end

      it 'returns 201' do
        expect(response).to have_http_status(:created)
      end

      it 'persists the reminder' do
        reminder = Reminder.last
        expect(reminder.label).to eq(@reminder_attributes[:label])
        expect(reminder.due_date).to eq(Date.parse(@reminder_attributes[:due_date]))
        expect(reminder.status.to_sym).to eq(@reminder_attributes[:status])
        expect(reminder.amount).to eq(@reminder_attributes[:amount].to_f)
        expect(reminder.recurrent).to eq(@reminder_attributes[:recurrent])
        expect(reminder.user).to eq(@user)
      end
    end
  end

  describe 'PUT /api/v1/reminder' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :put, '/api/v1/reminders/0'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @reminder = create(:reminder)
        @reminder_attributes = attributes_for(:reminder)
        put(
          "/api/v1/reminders/#{@reminder.id}",
          params: { reminder: @reminder_attributes },
          headers: header_with_authentication(@user)
        )
      end

      it 'returns 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the reminder' do
        @reminder.reload
        expect(@reminder.label).to eq(@reminder_attributes[:label])
        expect(@reminder.due_date).to eq(Date.parse(@reminder_attributes[:due_date]))
        expect(@reminder.status.to_sym).to eq(@reminder_attributes[:status])
        expect(@reminder.amount).to eq(@reminder_attributes[:amount].to_f)
        expect(@reminder.recurrent).to eq(@reminder_attributes[:recurrent])
        expect(@reminder.user).to eq(@user)
      end
    end
  end

  describe 'DELETE /api/v1/reminders' do
    context 'without authenticated header' do
      it_behaves_like :deny_access, :put, '/api/v1/reminders/0'
    end

    context 'with authenticated header' do
      before do
        @user = create(:user)
        @reminder = create(:reminder)
        delete(
          "/api/v1/reminders/#{@reminder.id}",
          params: {},
          headers: header_with_authentication(@user)
        )
      end

      it 'returns 200' do
        expect_status(200)
      end

      it 'Reminder is deleted' do
        expect(Reminder.all.count).to eql(0)
      end
    end
  end
end
