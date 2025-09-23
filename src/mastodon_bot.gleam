import gleam/erlang/process
import gleam/http/request
import gleam/http/response
import gleam/httpc
import gleam/io
import gleam/otp/actor
import gleam/result

// Local imports
import cron

pub type Message {
  Shutdown
  Log(text: String)
}

fn handle_message(state: Nil, message: Message) -> actor.Next(Nil, Message) {
  case message {
    Shutdown -> {
      io.println("Shutting down actor")
      actor.stop()
    }
    Log(text) -> {
      io.println("Log message received: " <> text)
      actor.continue(state)
    }
  }
}

fn job() {
  io.println("Task executed!")
  let _wow = echo send_request()

  Nil
}

pub fn main() {
  cron.start_cron(job)

  let assert Ok(actor) =
    actor.new(Nil)
    |> actor.on_message(handle_message)
    |> actor.start

  let subject = actor.data

  process.send(subject, Log("Hello from main"))
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
