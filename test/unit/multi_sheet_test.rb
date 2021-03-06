require 'test_helper'

class MultiSheetTest < ActiveSupport::TestCase

  def setup
    @test_data = [[1,2,3], [4,5,6], [7,8,9]]
  end

  test "xlsx" do
    package = Post.to_axlsx_package
    package = CustomPost.to_axlsx_package({sheet_name: 'Latest Projects'}, package)
    package = SpreadsheetArchitect.to_axlsx_package({data: @test_data, sheet_name: 'Another Sheet'}, package)

    File.open(VERSIONED_BASE_PATH.join("multi_sheet.xlsx"),'w+b') do |f|
      f.write package.to_stream.read
    end
  end

  test "ods" do
    spreadsheet = Post.to_rodf_spreadsheet
    spreadsheet = CustomPost.to_rodf_spreadsheet({sheet_name: 'Latest Projects'}, spreadsheet)
    spreadsheet = SpreadsheetArchitect.to_rodf_spreadsheet({data: @test_data, sheet_name: 'Another Sheet'}, spreadsheet)

    File.open(VERSIONED_BASE_PATH.join("multi_sheet.ods"),'w+b') do |f|
      f.write spreadsheet.bytes
    end
  end

end
