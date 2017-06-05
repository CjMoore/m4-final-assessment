require 'rails_helper'

describe 'get recent_links' do
  it 'returns array of recently read links' do
    user = User.create(email: 'email@email.com', password: 'pass')
    link1 = user.links.create(url: 'https://google.com', title: 'Google', read: true, updated_at: Time.now)

    link2 = user.links.create(url: 'https://reddit.com', title: 'Reddit', read: true, updated_at: Time.now)

    user2 = User.create(email: 'a@email.com', password: 'pass')

    link3 = user2.links.create(url: 'https://google.com', title: 'Google', read: true, updated_at: Time.now)

    link4 = user2.links.create(url: 'https://facebook.com', title: 'Facebook', read: true, updated_at: 2.days.ago)

  

    get '/api/v1/recent_links'

    expect(response).to be_success
  end
end
