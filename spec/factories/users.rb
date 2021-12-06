FactoryBot.define do
  factory :user do
    nickname {Faker::Name.first_name}
    email    {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    kanji_family_name {'田中'}
    kanji_first_name {'太郎'}
    kana_family_name {'タナカ'}
    kana_first_name {'タロウ'}
    birth_date {Faker::Date.between(from: '1930-01-01', to: '2016-12-31')}
  end
end