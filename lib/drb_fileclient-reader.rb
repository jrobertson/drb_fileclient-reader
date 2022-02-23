#!/usr/bin/env ruby

# file: drb_fileclient-reader.rb

require 'drb'
require 'c32'


class DRbFileClientReader
  using ColouredText

  def initialize(location=nil, host: nil, port: '61010', debug: false)

    @debug = debug

    if location then

      host = location[/(?<=^dfs:\/\/)[^\/:]+/]
      port = location[/(?<=^dfs:\/\/)[^:]+:(\d+)/,1]  || '61010'
      @@directory = location[/(?<=^dfs:\/\/)[^\/]+\/(.*)/,1]
    else
      @@directory = nil
    end

    DRb.start_service

  end

  def exists?(filename=@@filename)

    return File.exists? filename unless @@directory or filename =~ /^dfs:\/\//

    if filename =~ /^dfs:\/\// then
      @@file, filename2 = parse_path(filename)
    else

      filename2 = File.join(@@directory, filename)
    end

    @@file.exists?(filename2)

  end

  alias exist? exists?

  def read(filename=@@filename)

    return File.read filename, s unless @@directory or filename =~ /^dfs:\/\//

    if filename =~ /^dfs:\/\// then
      @@file, path = parse_path(filename)
    else
      path = File.join(@@directory, filename)
    end

    @@file.read path
  end

  protected

  def parse_path(filename)

    host = filename[/(?<=^dfs:\/\/)[^\/:]+/]
    @host = host if host

    port = filename[/(?<=^dfs:\/\/)[^:]+:(\d+)/,1]  || '61010'

    file_server = DRbObject.new nil, "druby://#{host || @host}:#{port}"
    [file_server, filename[/(?<=^dfs:\/\/)[^\/]+\/(.*)/,1], ("dfs://%s:%s" % [host, port])]

  end

end

class DfsFile

  @client = DRbFileClientReader.new

  def self.exists?(filename)    @client.exists?(filename)    end
  def self.read(filename)       @client.read(filename)       end

end
