(** Describe Errors *)

(** All errors *)
type t =
  | Unknown of string
  | Unclosed_loop of Location.t
  | Unopened_loop of Location.t
  | Loop_stagnation of Location.t

(** {2 Helpers} *)

val pp : Format.formatter -> t -> unit
val eq : t -> t -> bool
val to_string : t -> string
