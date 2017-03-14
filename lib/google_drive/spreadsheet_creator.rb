module GoogleDrive
  class SpreadsheetCreator
    def self.create_spreadsheet(sheet_key)
      client = OAuth2::Client.new(
        ENV['CLIENT_ID'],
        ENV['CLIENT_SECRET'],
        site: 'https://accounts.google.com',
        token_url: '/o/oauth2/token',
        authorize_url: '/o/oauth2/auth'
      )
      auth_options = {
        refresh_token: ENV['REFRESH_TOKEN'],
        expires_at: 3600
      }
      auth_token = OAuth2::AccessToken.from_hash(client, auth_options)
      auth_token = auth_token.refresh!
      session = GoogleDrive.login_with_oauth(auth_token.token)
      session.spreadsheet_by_key(sheet_key).worksheets
    end
  end
end
