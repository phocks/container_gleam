import clockwork
import clockwork_schedule

pub fn start_cron(job) {
  let assert Ok(cron) = clockwork.from_string("*/1 * * * *")
  let scheduler = clockwork_schedule.new("my_task", cron, job)
  let assert Ok(_schedule) = clockwork_schedule.start(scheduler)

  Nil
}
