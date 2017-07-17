RSpec.describe Transcript::Controller, type: :controller do
  controller ActionController::Base do
    include Transcript::Controller

    def edit
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post)
      @meta = "metadata"
      audit_action @user, @post, @meta

      head :ok
    end

    def custom
      @user = FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post)
      @meta = "metadata"
      audit_action @user, @post, "custom", @meta

      head :ok
    end
  end

  it "creates an audit entry by inferring the action" do
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear
    routes.draw { get "edit" => "anonymous#edit" }

    get :edit

    expect(Transcript::Job).to have_been_enqueued
                           .with do |actor, receiver, action, meta|
      expect(actor).to be_a User
      expect(receiver).to be_a Post
      expect(action).to eq "edit"
      expect(meta).to eq "metadata"
    end
  end

  it "creates an audit entry with a given action" do
    ActiveJob::Base.queue_adapter.enqueued_jobs.clear
    routes.draw { get "custom" => "anonymous#custom" }

    get :custom

    expect(Transcript::Job).to have_been_enqueued
                           .with do |actor, receiver, action, meta|
      expect(actor).to be_a User
      expect(receiver).to be_a Post
      expect(action).to eq "custom"
      expect(meta).to eq "metadata"
    end
  end
end
