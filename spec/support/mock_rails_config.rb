module Rails
  def self.configuration
    Struct.new(:database_configuration).new(database_configuration)
  end

  def self.env
    'development'
  end

  class << self
    private

    def database_configuration
      development = Struct.new(:symbolize_keys).new(
        url: 'mysql2://user:pwd@rails/db'
      )

      {
        'development' => development,
        'test' =>  { 'foo' => 'test' }
      }
    end
  end
end
