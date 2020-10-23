# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3001 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Initialize external clients after puma forks, but before it spawns threads

# This is important because we are using the puma middleware, which uses both a
# forking process model and threads to scale.

# There are two concerns:
# 1) thread safety of the avro_turf gem
# 2) thread safety of the class singletons

# For #1, the avro_turf gem author states:
#  "If you eagerly set the instance at application boot time then it's fine –
#   the async producer is thread safe, so multiple threads can produce using
#   it. That's in fact one of the main use cases for the async producer."

# For #2, we're defining the class singletons in an initializer, we need to
# instantiate the singleton here, at rails boot time, before the request cycles.
on_worker_boot do
  AsyncKafkaProducer.instance

  KafkaAvroTurf.instance
end

on_worker_shutdown do
  AsyncKafkaProducer.instance.shutdown
end
