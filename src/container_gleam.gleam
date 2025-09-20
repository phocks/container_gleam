import clockwork
import clockwork_schedule
import gleam/erlang/process
import gleam/io

pub fn main() {
  // Create a cron expression (runs every 5 minutes)
  let assert Ok(cron) = clockwork.from_string("*/1 * * * *")

  // Define your job
  let job = fn() { io.println("Task executed!") }

  // Create and start the scheduler
  let scheduler = clockwork_schedule.new("my_task", cron, job)
  let assert Ok(schedule) = clockwork_schedule.start(scheduler)

  // The task will run every 5 minutes until stopped
  // Stop when done
  clockwork_schedule.stop(schedule)

  process.sleep_forever()
}
