require 'lib/google_drive/spreadsheet_creator'
require 'lib/google_drive/spreadsheet'

namespace :spreadsheet_io do
  desc 'convert google spreadsheet'
  task :convert do |task, args|
    begin
      export_sheet_id = args[:export_sheet_id]
      import_sheet_id = args[:import_sheet_id]
      spreadsheets = GoogleDrive::SpreadsheetCreator.create_spreadsheet(export_sheet_id)
      worksheets = GoogleDrive::Spreadsheet.do_export(spreadsheets)

      # convert process

      spreadsheets = GoogleDrive::SpreadsheetCreator.create_spreadsheet(import_sheet_id)
      Googledrive::Spreadsheet.do_import(spreadsheets, worksheets)
    rescue StandardError => e
      raise e
    end
  end
end
