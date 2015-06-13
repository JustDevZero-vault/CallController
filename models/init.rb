require 'data_mapper'
require 'dm-mysql-adapter'
require 'dm-validations'
require 'fileutils'
require 'net/http'
require 'pathname'
require 'find'
require 'tempfile'
require 'mysql2'
require 'bcrypt'
require 'timeout'
require 'mail'
require 'htmlentities'
require 'redcarpet'
require 'base64'
require 'csv'
require 'dm_noisy_failures'


database_config = YAML.load_file( File.dirname(__FILE__) << "/../../private/configs/database.yml")
DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, database_config)

require_relative 'lib/spork'
require_relative 'lib/flavored_markdown'
require_relative 'notification'
require_relative 'role'
require_relative 'call_queue'
require_relative 'user'
require_relative 'country'
require_relative 'province'
require_relative 'setup'
require_relative 'setting'
require_relative 'email'
require_relative 'campaign_type'
require_relative 'campaign'
require_relative 'product'
require_relative 'call_result'
require_relative 'origin_sale'
require_relative 'sale'
DataMapper.finalize


if File.exist? '.installed'
  DataMapper.auto_upgrade!(:default)
end
