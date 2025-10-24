import clockwork
import clockwork_schedule
import gleam/erlang/process

pub fn start_cron(job) {
  let assert Ok(cron) = clockwork.from_string("*/1 * * * *")
  let name = process.new_name("my_task")
  let scheduler =
    clockwork_schedule.new("my_task", cron, job)
    |> clockwork_schedule.with_logging()

  let assert Ok(_schedule) = clockwork_schedule.start(scheduler, name)

  Nil
}
