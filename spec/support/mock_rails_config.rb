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
      {
        'development' =>  {
          'adapter' => 'mysql2',
          'foo' => 'dev'
        },
        'test' =>  { 'foo' => 'test' }
      }
    end
  end
end
