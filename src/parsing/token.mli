type t =
  | Memory of int
  | Cursor of int
  | Input
  | Output
  | Loop of t list
  | Clear

module Pp : sig
  val token : Format.formatter -> t -> unit
  val tokens : Format.formatter -> t list -> unit
end

module Eq : sig
  val token : t -> t -> bool
  val tokens : t list -> t list -> bool
end
