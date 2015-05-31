require "data_mapper"
require "dm-mysql-adapter"
require 'fileutils'
require 'pathname'
require 'find'
require 'tempfile'
require 'mysql2'
require 'bcrypt'
require 'timeout'
require 'mail'
require 'htmlentities'
require 'redcarpet'

database_config = YAML.load_file( File.dirname(__FILE__) << "/../../private/configs/database.yml")
DataMapper.setup(:default, database_config)

require_relative "lib/spork"
require_relative "lib/flavored_markdown"
require_relative "role"
require_relative "user"
require_relative "setup"
require_relative "campaign_type"
require_relative "campaign"
require_relative "product"
require_relative "call_result"
require_relative "origin_sales"
require_relative "sale"
DataMapper.finalize


if File.exist? '.installed'
  DataMapper.auto_upgrade!(:default)
end
