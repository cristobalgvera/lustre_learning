import gleam/int
import lustre
import lustre/element
import lustre/element/html
import lustre/event

pub fn main() {
  let app = lustre.simple(init, update, view)

  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

type Model =
  Int

fn init(_flags) -> Model {
  0
}

type Message {
  Increment
  Decrement
}

fn update(model: Model, message: Message) -> Model {
  case message, model {
    Increment, _ -> model + 1
    Decrement, 0 -> 0
    Decrement, _ -> model - 1
  }
}

fn view(model: Model) -> element.Element(Message) {
  let count = int.to_string(model)

  html.div([], [
    element.text(count),
    html.hr([]),
    html.button([event.on_click(Decrement)], [element.text("-")]),
    html.button([event.on_click(Increment)], [element.text("+")]),
  ])
}
