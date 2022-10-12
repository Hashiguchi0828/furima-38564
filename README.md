# README

# users
| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

has_many :items
has_many :buyers


# items
| Column            | Type    | Options     |
| ----------------- | ------- | ----------- |
| name              | string  | null: false |
| description       | text    | null: false |
| category_id       | integer | null: false |
| status_id         | integer | null: false |
| postage_id        | integer | null: false |
| shipping_date_id  | integer | null: false |
| price             | string  | null: false |
| prefecture_id     | integer | null: false |
| user              | references | null: false, foreign_key:true |

belongs_to :user
has_one :buyer


# buyers
| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| user             | references | null: false, foreign_key:true |
| item             | references |null: false, foreign_key:true  |

has_one :address
belongs_to :item
belongs_to :user


# addresses
| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| postal_code       | string     | null: false  |
| prefecture_i      | integer    | null: false  |
| city              | string     | null: false  |
| address           | string     | null: false  |
| apartment         | string     |              |
| phone_number      | string     | null: false  |
| buyer             | references | null: false, foreign_key:true |

belongs_to :buyer

