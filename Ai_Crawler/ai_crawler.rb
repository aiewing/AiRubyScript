require_relative 'spider'
require_relative 'command_line_argument_parser'
require_relative 'url_store'

class AiCrawler
  def initialize
    @argument_parse = CommandLineArgumentParser.new
    @argument_parse.parse_arguments
    @spider = Spider.new
    @url_store = UrlStore.new(@argument_parse.url_file)
  end

  def startCrawl
    puts "crawl model：#{@argument_parse.crawl_type}"
    puts "crawl depth：#{@argument_parse.crawl_depth}"
    puts "crawl page limit：#{@argument_parse.page_limit}"
    puts "crawl urls：#{@url_store.get_urls}"

    if @argument_parse.crawl_type == CommandLineArgumentParser::WEB_CRAWLER
      @spider.crawl_web(
        @url_store.get_urls,
        @argument_parse.crawl_depth,
        @argument_parse.page_limit
      )
    else
      @spider.crawl_domain(
        @url_store.get_url,
        @argument_parse.page_limit
      )
    end
  end
end