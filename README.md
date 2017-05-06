# MPCS 52553 - Final Project Starting Point

* Download the ZIP of this repository to start your project.  
* Rename your folder to `mpcs52553-final`

<hr>

Or, you can create a new Rails app yourself and follow these steps:

1. Generate a new Rais app: `rails new mpcs52553-final --skip-bundle`
2. Add `gem 'ez'` inside the `Gemfile`
3. `bundle install`
4. Then customize the `config/development.rb` as follows:

    ```
      config.assets.debug = false
      config.assets.digest = false
    ```

Now you can start developing.  Happy coding!
