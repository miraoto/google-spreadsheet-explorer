require 'google_drive'

module GoogleDrive
  class SpreadsheetCreator
    def self.create_spreadsheet(sheet_key)
      # SEE: https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
      session = GoogleDrive::Session.from_service_account_key(ENV['JSON_KEY_PATH'])
      session.spreadsheet_by_key(sheet_key).worksheets
    end
  end
end
