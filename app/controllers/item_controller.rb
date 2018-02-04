require 'open-uri'
require 'json'

class ItemController < ApplicationController
  def index
    num_items = 0
    @items = []
    list = JSON.parse(open("https://hacker-news.firebaseio.com/v0/topstories.json").read)
    30.times do |i|
      @items.push(JSON.parse(open("https://hacker-news.firebaseio.com/v0/item/" + list[i].to_s + ".json").read))
      num_items = num_items + 1
    end
  end
end
