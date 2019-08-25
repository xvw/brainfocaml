(** Describe a Location *)

(** Location *)
type t =
  { line : int
  ; column : int
  }

(** {2 Helpers} *)

val make : ?line:int -> ?column:int -> unit -> t
val move_left : t -> t
val move_right : t -> t
val move_up : t -> t
val move_down : t -> t
val pp : Format.formatter -> t -> unit
val eq : t -> t -> bool
val to_string : t -> string
