# Implements Questions 6
# General/misc tasks
class general {
  # get the current time
  $time = generate('/bin/date', '+%H:%M:%S')
  # tell the client the start time
  notify { 'start time':
    name     => 'start-time',
    message  => "Agent run starting at ${time}"
  }
}
