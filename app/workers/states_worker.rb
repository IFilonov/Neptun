class StatesWorker
  include Sidekiq::Worker

  def perform(*args)
    services = Service.all
  end
end
