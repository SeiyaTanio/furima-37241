# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| kanji_family_name  | string | null: false               |
| kanji_first_name   | string | null: false               |
| kana_family_name   | string | null: false               |
| kana_first_name    | string | null: false               |
| birth_date         | date   | null: false               |

### Association

- has_many :items
- has_many :orders


## テーブルitems

| Column            | Type       | Options                        |
|-------------------|------------|--------------------------------|
| item_name         | string     | null: false                    |
| describe          | text       | null: false                    |
| category          | string     | null: false                    |
| status            | string     | null: false                    |
| delivery_fee_load | string     | null: false                    |
| shipment_source   | string     | null: false                    |
| sending_date      | string     | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## ordersテーブル

| Column         | Type       | Options                       |
|----------------|------------|-------------------------------|
| user           | references | null: false foreign_key: true |
| item           | references | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## addressesテーブル

| Column         | Type       | Options                       |
|----------------|------------|-------------------------------|
| postal_code    | integer    | null: false                   |
| prefecture     | string     | null: false                   |
| municipalities | string     | null: false                   |
| house_number   | string     | null: false                   |
| building_name  | string     |                               |
| tel_number     | integer    | null: false                   |
| order          | references | null: false foreign_key: true |

### Association

- belongs_to :order