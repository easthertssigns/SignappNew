class FogConnector
  def get_fog_connection

    config = load_yaml_s3_config

    Fog::Storage.new(
        :provider => 'AWS',
        :aws_secret_access_key => config['aws_secret_access_key'],
        :aws_access_key_id => config['aws_access_key_id']
    )
  end

  def get_bucket_name
    load_yaml_s3_config['bucket_name']
  end

  def get_s3_pre_url
    "http://s3.amazonaws.com/" + FogConnector.new().get_bucket_name + "/"
  end

  private

  def load_yaml_s3_config
    YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 's3.yml'))).result)[Rails.env]
  end
end