# Twitter Clone

A mini-featured Twitter-like social media platform built with Ruby on Rails 7.2, Hotwire.
---

## Table of Contents

- [Features](#features)
- [Technical Design](#technical-design)
- [Database Schema](#database-schema)
- [Setup & Installation](#setup--installation)
- [Running Tests](#running-tests)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- **Authentication**: Secure registration, login, logout, password reset, and account email activation.
- **Microposts**: Users can create, display, and delete tweets (microposts) with optional image uploads.
- **User Profiles**: View user info, avatar (Gravatar), micropost count, and follow/follower stats.
- **Feed**: Personalized feed showing own and followed users' posts.
- **Follow System**: Follow/unfollow users, see followers/following lists and counts.
- **Responsive UI**: Mobile-ready, Twitter-inspired design using SCSS.
- **Email Notifications**: Activation and password reset emails via ActionMailer.
- **Docker Support**: Containerized for easy local development and deployment.

---

## Technical Design

### Architecture Overview

- **MVC Structure**: Rails models for Users, Microposts, Relationships; RESTful controllers and ERB views.
- **Authentication**: Secure password handling with bcrypt, persistent sessions, and token-based account activation.
- **Microposts**: Text (max 140 chars), optional image uploads via ActiveStorage, ordered by most recent.
- **Feed Algorithm**: User feed combines own microposts and posts from followed users, efficiently indexed.
- **Follow System**: Self-referential Relationship model tracks who follows whom; bi-directional associations for followers and following.
- **Frontend**: Uses Hotwire (Turbo/Stimulus) for fast, real-time updates; Importmap for JS management.
- **Styling**: Custom SCSS for layouts, user lists, microposts, stats, and responsive design.
- **Mailer**: ActionMailer for email delivery; mailer previews for development.
- **Docker**: Multi-stage Dockerfile for building, assets precompilation, and lightweight runtime.

### Key Models & Associations

- **User**
  - Has many microposts (dependent destroy)
  - Has many active and passive relationships (for follows/followers)
  - Validations: name, email (format, uniqueness), password
  - Authentication: password_digest, remember/activation/reset tokens
- **Micropost**
  - Belongs to user
  - Validates content length and presence
  - Supports image attachment (ActiveStorage)
- **Relationship**
  - Belongs to follower and followed (User)
  - Enforces unique follower-followed pairs

---

## Database Schema

### Entity Relationship Diagram

```
users
 ├─ id : PK
 ├─ name : string
 ├─ email : string (unique)
 ├─ password_digest : string
 ├─ remember_digest : string
 ├─ admin : boolean
 ├─ activation_digest : string
 ├─ activated : boolean
 ├─ activated_at : datetime
 ├─ reset_digest : string
 ├─ reset_sent_at : datetime
 └─ timestamps

microposts
 ├─ id : PK
 ├─ content : text
 ├─ user_id : FK → users.id
 ├─ created_at, updated_at
 └─ indexes: [user_id, created_at]

relationships
 ├─ id : PK
 ├─ follower_id : FK → users.id
 ├─ followed_id : FK → users.id
 ├─ timestamps
 └─ unique index: [follower_id, followed_id]

(active_storage tables for images)
```

---

## Setup & Installation

### Prerequisites

- Ruby (>= 3.2), Bundler
- Node.js & Yarn (if working with assets)
- Docker (optional)
- SQLite3 (default; swap for PostgreSQL/MySQL as needed)

### Local Setup

```bash
git clone https://github.com/amrhossamdev/twitter-clone.git
cd twitter-clone
gem install bundler
bundle install
bin/rails db:setup
bin/rails db:seed   # (optional: loads sample users and microposts)
bin/rails server
# Visit http://localhost:3000
```

### Docker Setup

```bash
docker build -t twitter-clone .
docker run -p 3000:3000 twitter-clone
```

---

## Running Tests

```bash
bin/rails test
```
Includes model, controller, and integration tests for core features.

---

## Deployment

- Prepare assets and environment variables as needed.
- Use Docker or standard Rails deployment.
- Email delivery requires SMTP configuration.

---

## Contributing

1. Fork the repo and clone locally.
2. Create a feature branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add feature'`)
4. Push and open a Pull Request.

---

## License

MIT

---

## Credits

Inspired by the Ruby on Rails Tutorial, Michael Hartl, and Twitter’s feature set.

For questions or issues, open a GitHub issue.
