class Hulaki::Twilio
  attr_reader :to, :from, :message

  def initialize(params = {})
    @to = params[:to]
    @message = params[:message]

    @config = params[:config]['keys']
    @from = params.fetch(:from, @config['TWILIO_PHONE_NUMBER'])
    @client = Twilio::REST::Client.new @config['TWILIO_ACCOUNT_SID'],
                                       @config['TWILIO_AUTH_TOKEN']
  end

  def send
    return true if @@mode == 'test'
    @client.messages.create(
        from: from,
        to: to,
        body: message
    )
  end

  class << self
    @@mode = 'live'

    def mode=(mode)
      @@mode = mode
    end

    def mode
      @@mode
    end
  end

end
