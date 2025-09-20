import clockwork
import clockwork_schedule
import gleam/erlang/process
import gleam/http/request
import gleam/http/response
import gleam/httpc
import gleam/io
import gleam/result

pub fn main() {
  let assert Ok(cron) = clockwork.from_string("*/1 * * * *")

  let job = fn() {
    io.println("Task executed!")
    echo send_request()

    Nil
  }

  // Create and start the scheduler
  let scheduler = clockwork_schedule.new("my_task", cron, job)
  let assert Ok(_schedule) = clockwork_schedule.start(scheduler)

  // clockwork_schedule.stop(schedule)

  process.sleep_forever()
}

pub fn send_request() {
  // Prepare a HTTP request record
  let assert Ok(base_req) =
    request.to("https://test-api.service.hmrc.gov.uk/hello/world")

  let req =
    request.prepend_header(base_req, "accept", "application/vnd.hmrc.1.0+json")

  // Send the HTTP request to the server
  use resp <- result.try(httpc.send(req))

  // We get a response record back
  assert resp.status == 200

  let content_type = response.get_header(resp, "content-type")
  assert content_type == Ok("application/json")

  assert resp.body == "{\"message\":\"Hello World\"}"

  Ok(resp)
}
