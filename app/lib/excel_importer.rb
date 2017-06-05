class ExcelImporter
  def initialize(filename, _row, data)
    p = Axlsx::Package.new
    p.workbook.add_worksheet(name: 'Messages') do |sheet|
      sheet.add_row
      data.each do |obj|
        sheet.add_row obj
      end
    end
    p.use_shared_strings = true
    p.serialize(filename)
  end
end
