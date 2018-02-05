require 'open-uri'
require 'json'
require 'date'

class ItemController < ApplicationController
  @@iteration = 0
  def index
    num_items = 0 + 30 * @@iteration
    @items = []
    list = JSON.parse(open("https://hacker-news.firebaseio.com/v0/topstories.json").read)
    30.times do |i|
      num_items += 1
      content = {}
      item = JSON.parse(open("https://hacker-news.firebaseio.com/v0/item/" + list[num_items-1].to_s + ".json").read)
      content['id'] = list[num_items-1]
      content['comment_link'] = 'https://news.ycombinator.com/item?id=' + content['id'].to_s
      content['ranking'] = num_items
      content['title'] = item['title']
      content['url'] = item['url']
      if content['url'] == nil
        content['host'] = ''
        content['host_search'] = ''
      else
        host = URI(item['url']).host
        if host.start_with?('www.')
          host = host[4..-1]
        end
        content['host'] = '(' + host.to_s + ')'
        content['host_search'] = "https://news.ycombinator.com/from?site=" + host.to_s
      end
      if item['score'] <= 1
        content['score'] = item['score'].to_s + ' point'
      else
        content['score'] = item['score'].to_s + ' points'
      end
      content['by'] = item['by']
      content['by_link'] = 'https://news.ycombinator.com/user?id=' + item['by']
      time_elapsed = Time.at(Time.now.to_i - item['time']).utc.strftime("%H%M%S").to_i.to_s
      time_elapsed_length = time_elapsed.length
      time_display = ''
      if time_elapsed.length == 6
        time_display = time_elapsed[0..1] + ' hours'
      elsif time_elapsed.length == 5
        if time_elapsed[0] == '1'
          time_display = time_elapsed[0] + ' hour'
        else
          time_display = time_elapsed[0] + ' hours'
        end
      elsif time_elapsed.length == 4
        time_display = time_elapsed[0..1] + ' minutes'
      elsif time_elapsed.length == 3
        if time_elapsed[0] == '1'
          time_display = time_elapsed[0] + ' minute'
        else
          time_display = time_elapsed[0] + ' minutes'
        end
      elsif time_elapsed.length == 2
        time_display = time_elapsed[0..1] + ' seconds'
      else time_elapsed.length == 1
        if time_elapsed[0] == '1'
          time_display = time_elapsed[0] + ' second'
        else
          time_display = time_elapsed[0] + ' seconds'
        end
      end
      content['time'] = time_display
      if item['kids'] == nil
        content['comment'] = 'discuss'
      else
        content['comment'] = item['kids'].length.to_s + ' comments'
      end
      @items.push(content)
    end
    respond_to do |format|
      format.html
      format.xml { render :xml => @items.to_xml }
    end
    @@iteration += 1
  end

end
