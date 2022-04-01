![](https://img.shields.io/badge/Microverse-blueviolet)

# BlogApp

> A simple blog application based on ruby on rails.


## Built With

- Ruby
- Rails
- HTML&CSS

## Getting Started

To get a local copy up and running follow the steps below.

### Prerequisites
- Ruby
- Rails

### Setup
- `git clone` this repo
- `cd` into the generated directory
- Run `bundle install`
- In the pgsql, create a new role with the name of "postgres"
- export DATABASE_PASSWORD= 123456
- Run `rails db:create` 
- Run `rails db:migrate` 
- Run `rails db:seed` 
- Run `rails s` 
Note: In case this doesn't work, try `rails db:drop` and do the steps all over again

### Install
- Run `bundle install` to install all the necessary dependencies
  
### Tests

- Open a terminal and cd into the project folder.
- Run `rspec ./spec/controllers/users_spec.rb`
- Run `rspec ./spec/controllers/posts_spec.rb`

### Usage
- Run `rails s` to expose a local webserver

## Author

👤 **Richard Chambula**

- GitHub: [@rtonata88](https://github.com/rtonata88)
- Twitter: [@rtonata](https://twitter.com/rtonata)
- LinkedIn: [Richard Chambula](https://www.linkedin.com/in/richard-chambula-49198425/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/oliverscz/blog-app/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](./MIT.md) licensed.
