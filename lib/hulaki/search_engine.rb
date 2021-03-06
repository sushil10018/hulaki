class Hulaki::SearchEngine
  include Amatch

  def initialize
    contact_parser = Hulaki::ContactParser.new
    @csv_data = contact_parser.perform
  end

  def perform(search_data)
    unless @csv_data.nil?
      search(search_data)
    end
  end

  private

  def search(data)
    result = search_result(data).select { |x| x[1] > 0.3 }
    result.sort { |x, y| y[1] <=> x[1] }
  end

  def search_result(data)
    @csv_data.map do |row|
      pt = 0.0
      row.each do |k, v|
        keys_to_search.each do |key|
          if k.to_s.match(key.to_s)
            pt += PairDistance.new(v.to_s).match(data.to_s)
          end
        end
      end
      weight = pt / keys_to_search.count
      percentage = weight *100
      [row, percentage]
    end
  end

  def keys_to_search
    ['name', 'email', 'phone']
  end
end
