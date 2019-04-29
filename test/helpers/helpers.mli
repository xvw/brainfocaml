val test : string -> (unit -> unit) -> string * [> `Quick ] * (unit -> unit)

module Pp : sig
  val token : Format.formatter -> Lib.Parser.token -> unit
  val tokens : Format.formatter -> Lib.Parser.tokens -> unit
  val program : Format.formatter -> Lib.Parser.program -> unit
end

module Eq : sig
  val token : Lib.Parser.token -> Lib.Parser.token -> bool
  val tokens : Lib.Parser.tokens -> Lib.Parser.tokens -> bool
  val program : Lib.Parser.program -> Lib.Parser.program -> bool
end

module Testable : sig
  val program : Lib.Parser.program Alcotest.testable
  val location : Lib.Location.t Alcotest.testable
  val error : Lib.Error.t Alcotest.testable
  val result : 'a Alcotest.testable -> 'a Lib.Result.t Alcotest.testable
end

module Check : sig
  val string : string -> string -> Lib.Parser.program Lib.Result.t -> unit
end
