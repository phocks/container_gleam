import gleam/erlang/process

import cron
import tasks

pub fn main() {
  cron.start_cron(tasks.job)
  process.sleep_forever()
}
