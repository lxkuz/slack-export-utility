class ExcelImporter
  SPLIT_SYMBOL = ','.freeze

  def initialize(filename, head_row)
    @filename = filename
    File.open(@filename, 'a') do |f|
      f.puts(head_row.join(SPLIT_SYMBOL))
    end
  end

  def append(data)
    File.open(@filename, 'a') do |f|
      data.each do |record|
        f.puts record.map { |r| wrap(r) }.join(SPLIT_SYMBOL)
      end
    end
  end

  private

  def wrap(o)
    '"' + o.to_s + '"'
  end
end
