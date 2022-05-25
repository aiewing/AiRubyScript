require 'getoptlong'

class CommandLineArgumentParser
  WEB_CRAWLER = 'web'
  DOMAIN_CRAWLER = 'domain'
  attr_reader :crawl_type, :crawl_depth, :page_limit, :url_file

  def initialize
    unless ARGV.length >= 1
      display_usage
      exit
    end

    @opts = GetoptLong.new(
      ["--crawl", "-c", GetoptLong::REQUIRED_ARGUMENT],
      ["--crawl-depth", "-d", GetoptLong::OPTIONAL_ARGUMENT],
      ["--page-limit", "-p", GetoptLong::OPTIONAL_ARGUMENT],
      ["--url-file", "-f", GetoptLong::OPTIONAL_ARGUMENT]
    )
    @crawl_type = "web"
    @crawl_depth = 3
    @page_limit = 100
    @url_file = "urls.txt"
  end

  def display_usage
    puts "Sample usage:"
    puts "ruby xxx.ruby -c web -d 3 -p 100 -f urls.txt"
    puts "-c must be either web or domain, will default to web"
  end

  # 解析参数
  def parse_arguments
    @opts.each do |opt, arg|
      case opt
      when '--craw'
        ensure_crawl_type_correct(arg)
      when '--crawl-depth'
        @crawl_depth = arg.to_i
      when '--page-limit'
        @page_limit = arg.to_i
      when '--url-file'
        @url_file = arg
      end
    end
  end

  def ensure_crawl_type_correct(value)
    if value == DOMAIN_CRAWLER
      @crawl_type = DOMAIN_CRAWLER
    else
      @crawl_type = WEB_CRAWLER
    end
  end

end