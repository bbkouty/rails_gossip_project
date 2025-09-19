# Gossip Project

## 1️⃣ Description

Gossip Project est une application web développée avec Ruby on Rails.
Elle permet de créer des Gossips, de les associer à des Tags, d’envoyer des messages privés, de poster des commentaires et de liker des gossips ou commentaires.
Le projet inclut :
- Gestion des villes et des utilisateurs.
- Publication de gossips par les utilisateurs.
- Association des gossips à des tags.
- Envoi de messages privés avec destinataires multiples.
- Système de commentaires et likes sur gossips et commentaires.
---

## 2️⃣ Prérequis

- Ruby ≥ 3.4
- Rails ≥ 8.0
- SQLite (par défaut, pour le développement)
- Bundler
---

## 3️⃣ Installation

1. Cloner le projet
```
git clone <URL_DU_REPO>
cd rails_gossip_project
```
2. Installer les dépendances
```
bundle install
```
3. Créer la base de données et les tables
```
rails db:create
rails db:migrate
```
4. Charger les données de test (seed)
```
rails db:seed
```
---

## 4️⃣ Modèles principaux

#### Users

- Attributs : first_name, last_name, email, description, age, city_id
- Associations :
    - has_many :gossips
    - has_many :private_messages (envoi de messages)
    - has_many :recipients (messages reçus)

#### Gossip

- Attributs : title, content, user_id
- Associations :
    - belongs_to :user
    - has_many :gossip_tags
    - has_many :tags, through: :gossip_tags
    - has_many :comments, as: :commentable
    - has_many :likes, as: :likeable

#### Tag

- Attributs : title
- Associations :
    - has_many :gossip_tags
    - has_many :gossips, through: :gossip_tags

#### PrivateMessage

- Attributs : content, sender_id (user_id de l'expéditeur)
- Associations :
    - belongs_to :sender, class_name: 'User'
    - has_many :recipients
    - has_many :users, through: :recipients

#### Recipient

- Attributs : user_id, private_message_id
- Associations :
    - belongs_to :user
    - belongs_to :private_message

#### Comment

- Attributs : content, user_id, commentable_type, commentable_id
- Associations :
    - belongs_to :user
    - belongs_to :commentable, polymorphic: true

#### Like

- Attributs : user_id, likeable_type, likeable_id
- Associations :
    - belongs_to :user
    - belongs_to :likeable, polymorphic: true

#### City

- Attributs : name, zip_code
- Associations :
    - has_many :users
---

## 5️⃣ Utilisation

### Vérifier les données via console

```
rails console
```

#### Exemples d’interrogation :

```
User.all
Gossip.first.user
PrivateMessage.first.sender
PrivateMessage.first.recipients.map(&:user)
Comment.first.commentable
Like.first.likeable
```
