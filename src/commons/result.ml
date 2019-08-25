type 'a t = ('a, Error.t) result

let ok x = Ok x
let error x = Error x
let bind f = function Ok x -> f x | Error x -> error x
let map f = function Ok x -> Ok (f x) | Error x -> error x

module Infix = struct
  let ( >>= ) x f = bind f x
  let ( >|= ) x f = map f x
end

include Infix
