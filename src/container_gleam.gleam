import clockwork
import clockwork_schedule
import gleam/erlang/process
import gleam/io

pub fn main() {
  let assert Ok(cron) = clockwork.from_string("*/1 * * * *")

  let job = fn() { io.println("Task executed!") }

  // Create and start the scheduler
  let scheduler = clockwork_schedule.new("my_task", cron, job)
  let assert Ok(_schedule) = clockwork_schedule.start(scheduler)

  // clockwork_schedule.stop(schedule)

  process.sleep_forever()
}
