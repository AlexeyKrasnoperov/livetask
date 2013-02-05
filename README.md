# Livetask

Live broadcast from your background jobs.
Easy to use and efficient to build progress monitoring of background tasks on your web pages.

## Installation

Add this line to your application's Gemfile:

    gem 'livetask'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install livetask

## Usage

### Sidekiq
#### Worker
Include Livetask::Sidekiq::Worker inside of your sidekiq worker class
```ruby
    include Livetask::Sidekiq::Web
```
##### Task name
```ruby
    set_task_name('Eduard')
```
##### Logging
```ruby
    add_to_log('I were logged and successfully stored in redis!')
```
##### Status
```ruby
    set_status('in progress')
```
##### Progress
```ruby
    set_progress(100) #Completed!
```

#### Web
Include Livetask::Sidekiq::Web inside of your controller
```ruby
    include Livetask::Sidekiq::Web
```
##### List of all recorded tasks ids
```ruby
    get_tasks_ids
```
##### Task name
```ruby
    get_task_name(task_id)
```
##### Logging
To get a full log use:
```ruby
    get_log(task_id)
```
If you want to limit returned log, you can set 'from' and 'to' limits
```ruby
    get_log(task_id, 3) # Will return last 3 lines of log
    get_log(task_id, 12, 2) # Will return last 10 lines of log except the latest 2
```
##### Status
```ruby
    get_status(task_id)
```
##### Progress
```ruby
    get_progress(task_id)
```
##### Last changed at
```ruby
    get_last_changed_at(task_id)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
